{/*! 
     Provides interface and base class for developing TransModeler plugins.
     
     \modified    2019-07-17 17:46pm
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

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
    property Enabled: Boolean read write;
    property PluginDirectory: String read;
    property PluginInfo: String read;
    property PluginName: String read;
    property PluginVersion: String read;
    property VehicleFactory: UserVehicleFactory read;
  end;

  PluginEnabledEventHandler  = public block();  
  PluginDisabledEventHandler = public block();

  TsmPlugin = public abstract class(ITsmPlugin)
  private
    const PmlFileExtension : String = '.xml'; public;
    const UiDbFileExtension : String = '.dbd'; public;
    const AddPluginUiMacroName : String = 'AddPluginUI'; public;
    const RemovePluginUiMacroName : String = 'RemovePluginUI'; public;
    const UiRscCompilerName : String = 'rscc.exe'; public;
    const TsmUserPrefFolderName : String = 'User Preference'; public;

    var fEnabled: Boolean;
    var fEventSinkManager: ITsmEventSinkManager;
    var fUiDbFilePath, fPluginDirectory, fBasePmlFilePath, fUserPmlFilePath: String;
    var fTsmApp: ITsmApplication;
    var fPmEditor: IParameterEditor;

    class var fSingleton: ITsmPlugin := nil;   
  private
    constructor; empty;    

    finalizer;
    begin
      fEventSinkManager := nil;
      fPmEditor := nil;
      fTsmApp := nil;
    end;

    method OnPluginEnabled;
    begin
      if assigned(PluginEnabled) then PluginEnabled();
    end;

    method OnPluginDisabled;
    begin
      if assigned(PluginDisabled) then PluginDisabled();
    end;

    method DoEnablePlugin;
    begin
      fEventSinkManager.Connect(SupportedEventSinkTypes);
      AddPluginUI;
      OnPluginEnabled;
    end;

    method DoDisablePlugin;
    begin
      fEventSinkManager.Disconnect(SupportedEventSinkTypes);
      RemovePluginUI;
      OnPluginDisabled;
    end;

    method AddPluginUI;
    begin
      var lArgs, lRetVal: VARIANT;
      var lMacroName: OleString := AddPluginUiMacroName;
      var lDb: OleString := fUiDbFilePath;
      rtl.VariantInit(@lArgs);
      rtl.VariantInit(@lRetVal);
      fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
      rtl.VariantClear(@lRetVal);
    end;

    method RemovePluginUI;
    begin
      var lArgs, lRetVal: VARIANT;
      var lMacroName: OleString := RemovePluginUiMacroName;
      var lDb: OleString := fUiDbFilePath;
      rtl.VariantInit(@lArgs);
      rtl.VariantInit(@lRetVal);
      fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
      rtl.VariantClear(@lRetVal);
    end;

    method SubscribeEvents;
    begin
      for lType: TsmEventSinkType := TsmEventSinkType.Undefined to TsmEventSinkType.All do
        if (lType in SupportedEventSinkTypes) then Subscribe(fEventSinkManager.GetEventSink(lType));
    end;

    method ValidatePmlBaseFile;
    begin
      var lPmlBaseContent: String := GeneratePmlBaseContent;
      if lPmlBaseContent <> String.Empty then
        if not File.Exists(fBasePmlFilePath) then File.WriteText(fBasePmlFilePath, lPmlBaseContent);
    end;

    method ValidateUiDatabase;
    begin    
      method GisdkCompilerPath: String;
      begin
        var lTsmProgramFolder: OleString;
        fTsmApp.Get_ProgramFolder(out lTsmProgramFolder);
        result := Path.Combine(lTsmProgramFolder.ToString, UiRscCompilerName);
      end;
    
      if not File.Exists(fUiDbFilePath) then begin  
        var lCompileResult := CaliperScriptCompiler.Compile(
              GenerateUiScriptContent,  
              GisdkCompilerPath,        
              Path.GetPathWithoutExtension(fUiDbFilePath));

        if not lCompileResult.Success then
          raise new EUiScriptCompileErrorException(lCompileResult.Errors.JoinedString(Environment.LineBreak));
      end;
    end;
  protected
    [Conditional('DEBUG')]
    method Log(const aMessage: String);
    begin
      rtl.OutputDebugString(rtl.LPCWSTR(aMessage.ToCharArray));
    end;

    method ParameterParser: TsmPluginParameterParser;
    begin
      result := new TsmPluginParameterParser(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
    end;

    {$REGION 'Protected methods that must be implemented by a sub class.'}
    method GeneratePmlBaseContent: String; virtual; abstract;
    method GenerateUiScriptContent: String; virtual; abstract;
    method GetPluginInfo: String; virtual; abstract;
    method GetPluginName: String; virtual; abstract;
    method GetSupportedEventSinkTypes: TsmEventSinkTypes; virtual; abstract;
    method GetPluginVersion: String; virtual; abstract;
    method Subscribe(aEventSink: ITsmEventSink); virtual; abstract;
    {$ENDREGION}

    method GetUserVehicleFactory: UserVehicleFactory; virtual;
    begin
      result := nil;
    end;

  public
    constructor(const aPluginDirectory: String);
    begin
      fTsmApp   := CoTsmApplication.Create;
      fPmEditor := CoParameterEditor.Create;
      fEventSinkManager := new TsmEventSinkManager(fTsmApp);
      fEnabled := false;
      fPluginDirectory := aPluginDirectory;    

      fBasePmlFilePath := Path.Combine(fPluginDirectory, PluginName + PmlFileExtension);    

      var lTsmUserPrefFolder: OleString;
      fTsmApp.GetFolder(TsmUserPrefFolderName, out lTsmUserPrefFolder);
      fUserPmlFilePath := Path.Combine(lTsmUserPrefFolder.ToString, PluginName + PmlFileExtension);
    
      fUiDbFilePath := Path.Combine(fPluginDirectory, PluginName + UiDbFileExtension);
    
      // Attach event handlers to each permissible event sinks as specified in sub class.
      SubscribeEvents;
    end;
    
    class method CreateSingleton(const aPluginDirectory: String): Boolean;
    begin
      if assigned(fSingleton) then exit true;    
      fSingleton := CreateUserPlugin(aPluginDirectory);
      result := fSingleton.Initialize;        
      if not result then fSingleton := nil;
    end;

    method Initialize: Boolean;
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

    method OpenParameterEditor;
    begin
      fPmEditor.Edit(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
    end;
  public
    property Enabled: Boolean 
      read begin
        result := fEnabled;
      end
      write begin
        if fEnabled <> value then begin
          fEnabled := value;          
          if fEnabled then DoEnablePlugin else DoDisablePlugin;
        end;
      end;

    property PluginInfo: String 
      read GetPluginInfo;

    property PluginDirectory: String 
      read fPluginDirectory;
 
    property PluginName: String
      read begin
        result := GetPluginName;
      ensure
         not result.Contains(' ');
      end;

    property ProjectPmlFilePath: String
      read begin
        var lProjectFolder: OleString;
        fTsmApp.Get_ProjectFolder(out lProjectFolder);       
        result := if lProjectFolder.Length > 0 then Path.Combine(lProjectFolder.ToString, PluginName + PmlFileExtension) else String.Empty;
      end;

    property SupportedEventSinkTypes: TsmEventSinkTypes 
      read GetSupportedEventSinkTypes;      
    
    property VehicleFactory: UserVehicleFactory 
      read GetUserVehicleFactory;      
    
    property PluginVersion: String
      read begin
        exit GetPluginVersion;
      end;

    property TsmApplication: ITsmApplication 
      read fTsmApp;         
    
    class property Singleton: ITsmPlugin 
      read fSingleton;
    
    event PluginEnabled: PluginEnabledEventHandler;
    event PluginDisabled: PluginDisabledEventHandler;
  end;

end.