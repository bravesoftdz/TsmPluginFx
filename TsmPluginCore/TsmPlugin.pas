{/*! 
     Provides interface and base class for developing TransModeler plugins.
     
     \modified    2019-07-09 13:45pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

interface

uses
  rtl,
  RemObjects.Elements.RTL;

 [SymbolName('__tsm_user_plugin_factory_')]
 method CreateUserPlugin(const aPluginDirectory: not nullable String): ITsmPlugin; external;

type
  [COM, Guid('{D2B4B617-A1EB-46D1-9E8D-FC88B6E4DDFE}')]
  ITsmPlugin = public interface(IUnknown)
    method Initialize: Boolean;
    method OpenParameterEditor;
    property Active: Boolean read write;
    property Description: String read;
    property PluginDirectory: String read;
    property PluginName: String read;
    property UserVehicleFactory: IUserVehicleFactory read;
  end;

  PluginActivateEventHandler = public block();  
  PluginDeactivateEventHandler = public block();

  TsmPlugin = public abstract class(ITsmPlugin)
  private
    {/*! constants. */}
    const PmlFileExtension : String = '.xml'; public;
    const UiDbFileExtension : String = '.dbd'; public;
    const AddPluginUiMacroName : String = 'AddPluginUI'; public;
    const RemovePluginUiMacroName : String = 'RemovePluginUI'; public;
    const UiRscCompilerName : String = 'rscc.exe'; public;
    const TsmUserPrefFolderName : String = 'User Preference'; public;

    {/*! private fields. */}
    var fActive: Boolean;
    var fEventSinkManager: ITsmEventSinkManager;
    var fUiDbFilePath, fPluginDirectory, fBasePmlFilePath, fUserPmlFilePath: String;
    var fTsmApp: ITsmApplication;
    var fPmEditor: IParameterEditor;
    
    {/*! The singleton Plugin instance accessed as ITsmPlugin interface. */}
    class var fSingleton: ITsmPlugin := nil;   
  private
    constructor;
    finalizer;
    method OnPluginActivate;
    method OnPluginDeactivate;
    method DoActivate;
    method DoDeactivate;
    method AddPluginUI;
    method RemovePluginUI;
    method SubscribeEvents;
    method ValidatePmlBaseFile;
    method ValidateUiDatabase;
  protected
    [Conditional('DEBUG')]
    method Log(const aMessage: String);
    method ParameterParser: TsmPluginParameterParser;
    method GeneratePmlBaseContent: String; virtual; abstract;
    method GenerateUiScriptContent: String; virtual; abstract;
    method GetDescription: String; virtual; abstract;
    method GetPluginName: String; virtual; abstract;
    method GetSupportedEventSinkTypes: TsmEventSinkTypes; virtual; abstract;
    method Subscribe(aEventSink: ITsmEventSink); virtual; abstract;
    method GetUserVehicleFactory: IUserVehicleFactory; virtual;
  public
    constructor(const aPluginDirectory: String);
    class method CreateSingleton(const aPluginDirectory: String): Boolean;
    method Initialize: Boolean;
    method OpenParameterEditor;
  public
    {/*! A boolean flag indicating whether the plugin is activated or not. */}
    property Active: Boolean
      read begin
        result := fActive;
      end
      write begin
        if fActive <> value then begin
          fActive := value;
          if fActive then DoActivate else DoDeactivate;
        end;
      end;

    {/*! Description string of the plugin in JSON format. */}
    property Description: String
      read begin
        result := GetDescription;
      end;

    {/*! Current plugin directory. */}
    property PluginDirectory: String
      read begin
        result := fPluginDirectory;
      end;

    {/*! Name of the plugin. It must not contain spaces. */}
    property PluginName: String
      read begin
        result := GetPluginName;
        assert(not result.Contains(' '));
      end;

    {/*! Optional parameter file specific to an opened project. */}
    property ProjectPmlFilePath: String
      read begin
        result := String.Empty;
        var lProjectFolder: OleString;
        if Succeeded(fTsmApp.Get_ProjectFolder(out lProjectFolder)) then
          if lProjectFolder.Length > 0 then
            result := Path.Combine(lProjectFolder.ToString, PluginName + PmlFileExtension);
      end;

    {/*! Supported event sink types. */}
    property SupportedEventSinkTypes: TsmEventSinkTypes
      read begin
        result := GetSupportedEventSinkTypes();
      end;

    {/*! Uesr vehicle factory. */}
    property UserVehicleFactory: IUserVehicleFactory
      read begin
        result := GetUserVehicleFactory;
      end;
    
    class property Singleton: ITsmPlugin read fSingleton;

    event PluginActivate: PluginActivateEventHandler;
    event PluginDeactivate: PluginDeactivateEventHandler;
  end;

implementation

  class method TsmPlugin.CreateSingleton(const aPluginDirectory: String): Boolean;
  begin
    if assigned(fSingleton) then exit true;
    fSingleton := CreateUserPlugin(aPluginDirectory);
    result := fSingleton.Initialize;
    if not result then fSingleton := nil;
  end;

  constructor TsmPlugin(const aPluginDirectory: String);
  begin
    fTsmApp := CoTsmApplication.Create;
    fPmEditor := CoParameterEditor.Create;
    fEventSinkManager := new TsmEventSinkManager(fTsmApp);
    fActive := false;
    fPluginDirectory := aPluginDirectory;
    
    // Base Pml file path.
    fBasePmlFilePath := Path.Combine(fPluginDirectory, PluginName + PmlFileExtension);
    
    // User-specific Pml file path.
    var lTsmUserPrefFolder: OleString;
    fTsmApp.GetFolder(TsmUserPrefFolderName, out lTsmUserPrefFolder);
    fUserPmlFilePath := Path.Combine(lTsmUserPrefFolder.ToString, PluginName + PmlFileExtension);
    
    // Ui database file path.
    fUiDbFilePath := Path.Combine(fPluginDirectory, PluginName + UiDbFileExtension);
    
    // Attach event handlers to each permissible event sinks as specified in sub class.
    SubscribeEvents;
  end;

  method TsmPlugin.Initialize: Boolean;
  begin
    try
      ValidatePmlBaseFile;
      ValidateUiDatabase;
    except
      on E: EUiScriptCompileErrorException do begin
        result := false;
        Log(E.Message + E.Errors);
      end;
      on E: EDllModuleLoadingException do begin
        result := false;
        Log(E.Message);
      end;
      on E: Exception do begin
        result := false;
        Log(E.Message);
      end;
    end;
  end;

  constructor TsmPlugin;
  begin
    // Constructor should never be called.
  end;

  finalizer TsmPlugin;
  begin
    fEventSinkManager := nil;
    fPmEditor := nil;
    fTsmApp := nil;
  end;

  method TsmPlugin.OnPluginActivate;
  begin
    if assigned(PluginActivate) then
      PluginActivate();
  end;

  method TsmPlugin.OnPluginDeactivate;
  begin
    if assigned(PluginDeactivate) then
      PluginDeactivate();
  end;

  method TsmPlugin.DoActivate;
  begin
    fEventSinkManager.Connect(SupportedEventSinkTypes);
    AddPluginUI;
    OnPluginActivate;
  end;

  method TsmPlugin.DoDeactivate;
  begin
    fEventSinkManager.Disconnect(SupportedEventSinkTypes);
    RemovePluginUI;
    OnPluginDeactivate;
  end;

  method TsmPlugin.AddPluginUI;
  begin
    var lArgs, lRetVal: VARIANT;
    var lMacroName: OleString := AddPluginUiMacroName;
    var lDb: OleString := fUiDbFilePath;
    rtl.VariantInit(@lArgs);
    rtl.VariantInit(@lRetVal);
    fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
    rtl.VariantClear(@lRetVal);
  end;

  method TsmPlugin.RemovePluginUI;
  begin
    var lArgs, lRetVal: VARIANT;
    var lMacroName: OleString := RemovePluginUiMacroName;
    var lDb: OleString := fUiDbFilePath;
    rtl.VariantInit(@lArgs);
    rtl.VariantInit(@lRetVal);
    fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
    rtl.VariantClear(@lRetVal);
  end;

  method TsmPlugin.SubscribeEvents;
  begin
    for lType: TsmEventSinkType := TsmEventSinkType.Undefined to TsmEventSinkType.All do
      if (lType in SupportedEventSinkTypes) then Subscribe(fEventSinkManager.GetEventSink(lType));
  end;

  method TsmPlugin.ValidatePmlBaseFile;
  begin
    if not File.Exists(fBasePmlFilePath) then File.WriteText(fBasePmlFilePath, GeneratePmlBaseContent);
  end;

  method TsmPlugin.ValidateUiDatabase;
  begin
    if not File.Exists(fUiDbFilePath) then begin
      // Get TransModeler Gisdk resource resource compiler path.
      var lTsmProgramFolder: OleString;
      fTsmApp.Get_ProgramFolder(out lTsmProgramFolder);
      var lCompilerPath := Path.Combine(lTsmProgramFolder.ToString, UiRscCompilerName);

      // Get UI database file path, without file extension.
      var lUiDbFilePathWithoutExt := Path.GetPathWithoutExtension(fUiDbFilePath);

      // Do just-in-time compilation.
      var lCompileErrors: ImmutableList<String>;
      var lCompileSuccess := CaliperScriptCompiler.Compile(
              GenerateUiScriptContent,  // UI database script
              lCompilerPath,            // Caliper resource compiler path
              lUiDbFilePathWithoutExt,  // Target UI database path
              out lCompileErrors);      // Compilation errors

      // Raise exception if the compilation has errors.
      if not lCompileSuccess then
        raise new EUiScriptCompileErrorException(lCompileErrors.JoinedString(Environment.LineBreak));
    end;
  end;

  method TsmPlugin.OpenParameterEditor;
  begin
    fPmEditor.Edit(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
  end;

  method TsmPlugin.Log(const aMessage: String);
  begin
    rtl.OutputDebugString(rtl.LPCWSTR(aMessage.ToCharArray));
    //var lMessage: OleString := aMessage;
    //fTsmApp.LogErrorMessage(lMessage);
  end;

  method TsmPlugin.ParameterParser: TsmPluginParameterParser;
  begin
    result := new TsmPluginParameterParser(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
  end;

  method TsmPlugin.GetUserVehicleFactory: IUserVehicleFactory;
  begin
    result := nil;
  end;

end.