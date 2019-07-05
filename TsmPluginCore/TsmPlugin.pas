{/*! 
     \brief       Provides interface and base class for developing microsimulation plugins.
     \modified    2019-07-04 17:54pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  RemObjects.Elements.RTL;

type
  {/*!
       \brief
          After an interface object is created, ITsmPlugin::Initialize must be called and
          must return true before using the interface.

          The plugin's hosting Dll may have the following exported functions that can map
          to ITsmPlugin's methods and properties:

          - OpenParameterEditor  ITsmPlugin::OpenParameterEditor
          - ActivatePlugin       Set ITsmPlugin::Active to true
          - DeactivatePlugin     Set ITsmPlugin::Active to false
          - GetPluginInfo        ITsmPlugin::Description
   */}
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

  PluginActivateEventHandler 
    = public block();
  
  PluginDeactivateEventHandler 
    = public block();

  TsmPlugin = public abstract class(ITsmPlugin)
  private
    {/*! constants. */}
    const PmlFileExtension : String = '.xml'; public;
    const UiDbFileExtension : String = '.dbd'; public;
    const AddPluginUiMacroName : String = 'AddPluginUI'; public;
    const RemovePluginUiMacroName : String = 'RemovePluginUI'; public;
    const UiRscCompilerName : String = 'rscc.exe'; public;
    const TsmUserPrefFolderName : String = 'User Preference'; public;
    {/*! The singleton Plugin instance accessed as ITsmPlugin interface. */}
    class var Instance: ITsmPlugin; public;  
    {/*! private fields. */}
    var fActive: Boolean;
    var fEventSinkManager: ITsmEventSinkManager;
    var fUiDbFilePath, fPluginDirectory, fBasePmlFilePath, fUserPmlFilePath: String;
    var fTsmApp: ITsmApplication;
    var fPmEditor: IParameterEditor;
  private
    constructor;
    begin
      // Constructor should never be called.
    end;

    finalizer;
    begin
      fEventSinkManager := nil;
      fPmEditor := nil;
      fTsmApp := nil;
    end;

    method OnPluginActivate;
    begin
      if assigned(PluginActivate) then
        PluginActivate();
    end;

    method OnPluginDeactivate;
    begin
      if assigned(PluginDeactivate) then
        PluginDeactivate();
    end;

    method DoActivate;
    begin
      fEventSinkManager.Connect(SupportedEventSinkTypes);
      AddPluginUI;
      OnPluginActivate;
    end;

    method DoDeactivate;
    begin
      fEventSinkManager.Disconnect(SupportedEventSinkTypes);
      RemovePluginUI;
      OnPluginDeactivate;
    end;

    method AddPluginUI;
    begin
      var lArgs, lRetVal: rtl.VARIANT;
      var lMacroName: OleString := AddPluginUiMacroName;
      var lDb: OleString := fUiDbFilePath;
      rtl.VariantInit(@lArgs);
      rtl.VariantInit(@lRetVal);
      fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
      rtl.VariantClear(@lRetVal);
    end;

    method RemovePluginUI;
    begin
      var lArgs, lRetVal: rtl.VARIANT;
      var lMacroName: OleString := RemovePluginUiMacroName;
      var lDb: OleString := fUiDbFilePath;
      rtl.VariantInit(@lArgs);
      rtl.VariantInit(@lRetVal);
      fTsmApp.Macro(lMacroName, lDb, lArgs, out lRetVal);
      rtl.VariantClear(@lRetVal);
    end;

    {/*!
         \brief
            Attach event handlers to each permissable event sink.

         \remark
            There are two types of connections. One is between TSM and event sinks,
            the other is between eventSinks and event handlers. Here only the latter
            is wired up.
      */}
    method SubscribeEvents;
    begin
      for lType: TsmEventSinkType := TsmEventSinkType.Undefined to TsmEventSinkType.All do
        if (lType in SupportedEventSinkTypes) then Subscribe(fEventSinkManager.GetEventSink(lType));
    end;

    {/*!
         \brief
            Validate the Pml base file in plugin folder. When non-existing,
            a new one will be created.
     */}
    method ValidatePmlBaseFile;
    begin
      if not File.Exists(fBasePmlFilePath) then File.WriteText(fBasePmlFilePath, GeneratePmlBaseContent);
    end;

    {/*!
         \brief
            Validate the UI database file in plugin folder. When non-existing, a new one will be generated.

         \remark
            The UI database must include two macros AddPluginUI and RemovePluginUI
              - AddPluginUI     Add plugin related UI to TSM main user interface
              - RemovePluginUI  Remove plugin related UI from TSM main user interface

           Note that we don't enforce a check-up that the UI database indeed contains the two mandatory
           macros.
     */}
    method ValidateUiDatabase;
    begin
      if not File.Exists(fUiDbFilePath) then begin
        // Get TransModeler Gisdk resource resource compiler path.
        var lTsmProgramFolder: OleString;
        fTsmApp.Get_ProgramFolder(out lTsmProgramFolder);
        var lCompilerPath := Path.Combine(lTsmProgramFolder.ToString, UiRscCompilerName);

        // Get UI database file path, without file extension.
        var lUiDbFilePathWithoutExt := Path.GetPathWithoutExtension(fUiDbFilePath);

        // Do just-in-time compilation.
        var lCompileErrors: List<String>;
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
  protected
    [Conditional('DEBUG')]
    method Log(const aMessage: String);
    begin
      rtl.OutputDebugString(rtl.LPCWSTR(aMessage.ToCharArray));
      //var lMessage: OleString := aMessage;
      //fTsmApp.LogErrorMessage(lMessage);
    end;

    method ParameterParser: TsmPluginParameterParser;
    begin
      result := new TsmPluginParameterParser(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
    end;

    method GeneratePmlBaseContent: String; virtual; abstract;
    method GenerateUiScriptContent: String; virtual; abstract;
    method GetDescription: String; virtual; abstract;
    method GetPluginName: String; virtual; abstract;
    method GetSupportedEventSinkTypes: TsmEventSinkTypes; virtual; abstract;      
    method Subscribe(aEventSink: ITsmEventSink); virtual; abstract;
    
  
    method GetUserVehicleFactory: IUserVehicleFactory; virtual;
    begin
      result := nil;
    end;
  public
    constructor(aPluginDirectory: String);
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

    {/*!
         Opens up the parameter editor, using the pml base file and optional file.
         The optional file is defined only after a project has been opened.
      */}
    method OpenParameterEditor;
    begin
      fPmEditor.Edit(fBasePmlFilePath, fUserPmlFilePath, ProjectPmlFilePath);
    end;

  public
    {/*!
         A boolean flag indicating whether the plugin is activated or not.

         When its value is changed from false to true (i.e, activated), the plugin
         will insert its UI to TransModeler's main UI, while connecting its event sinks to
         the latter's connection points.

         When its value is set from true to fasle(i.e, deactivated), the plugin will
         remove its UI from TransModeler's main UI, while disconnecting its event sinks from
         the latter's connection points.
     */}
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

    event PluginActivate: PluginActivateEventHandler;
    event PluginDeactivate: PluginDeactivateEventHandler;
  end;
end.