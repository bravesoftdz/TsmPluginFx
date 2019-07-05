{/*!
     \brief
        Provides Dll entry point and defines exported functions for the microsimulation plugin.
        Four exported functions are mandatory for a microsimulation plugin:

          - OpenParameterEditor  Invokes an user-supplied editor for modifying the plugin parameters.
          - ActivatePlugin       Activates ehe plugin (like generate the associated user interface, prepare data connection etc).
          - DeactivatePlugin     Deactivates the plugin (like removing the associated user interface, clean up resources etc).
          - GetPluginInfo        Returns descriptive info about the plugin.
          - CreateUserVehicle    Create a user-defined vehicle for monitoring purpose, or for customized car-following logic.

     \modified    2019-07-04 14:30pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  rtl;

  {/*!
       \brief
          Returns the class reference of a TsmPlugin class. It must be implemented
          by the user-custom plugin logic.
  
       \remark
          This is not an export function. It is an internal function to be implemented
          by the costom user logic.
    */}
  [SymbolName('__tsm_plugin_class_')]
  method TsmPluginClass: class of TsmPlugin; external;

  {/*!
       \brief
          Invokes a user-supplied editor for editing plugin parameters.
    */}
  [SymbolName('OpenParameterEditor'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method OpenParameterEditor;
  begin
    TsmPlugin.Instance.OpenParameterEditor;
  end;

  {/*!
       \brief
          Activates the plugin. An associated user interface may be generated and inserted into
          the main user interface of the hosting microsimulator.
    */}
  [SymbolName('ActivatePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method ActivatePlugin;
  begin
    TsmPlugin.Instance.Active := true;
  end;

  {/*!
       \brief
          Deactivates the plugin. An associated user interface, if any, will be removed from
          the main user interface of the hosting microsimulator.
    */}
  [SymbolName('DeactivatePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method DeactivatePlugin;
  begin
    TsmPlugin.Instance.Active := false;
  end;

  {/*!
       \brief
          Returns a descriptive string about the plugin.
  
       \param  aPluginInfo
          A 0-indexed char pointer referencing a null-terminated string. If nil, then aSize will be ingored,
          and return value is the actual size of the plugin info string plus 1. The caller
          should allocate enough memory based on the returned size, and call this function again,
          with a non-null pointer.
       \param aSize
          Size of the memory space allocated for aPluginInfo, including the null character.

       \remark
          The caller is responsible for allocating and releasing memory for aPluginInfo.

       \returns
          Actual number of characters copied to aPluginInfo, including the null character.
    */}
  [SymbolName('GetPluginInfo'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetPluginInfo(aPluginInfo: LPWSTR := nil; aSize: DWORD): DWORD;
  begin
    with aDesc := TsmPlugin.Instance.Description do begin
      if not assigned(aPluginInfo) then exit (aDesc.Length + 1);
      var lInfo: array of Char := aDesc.ToCharArray;
      var lSize: DWORD := Math.Min(aSize, aDesc.Length + 1);
      aPluginInfo[lSize] := #0;
      memcpy(aPluginInfo, lInfo, sizeOf(Char) * (lSize - 1));
      exit lSize;
    end;
  end;

  [SymbolName('CreateUserVehicle'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method CreateUserVehicle(aID: LongInt; const var aProperty: VehicleProperty; aFlags: ^VehicleMonitorOption): PUserVehicle;
  begin
    if assigned(TsmPlugin.Instance.UserVehicleFactory) then
      result := TsmPlugin.Instance.UserVehicleFactory.CreateUserVehicle(aID, aProperty, aFlags);
  end;

  [SymbolName('__elements_dll_main', ReferenceFromMain := true)]
  method DllMain(aModule: rtl.HMODULE; aReason: rtl.DWORD; aReserved: ^Void): Boolean;
  begin
    case aReason of
      DLL_PROCESS_ATTACH:
      begin
        // Get module name of the hosting dll
        var lModuleName: array of Char := new Char[MAX_PATH];
        GetModuleFileName(aModule, lModuleName, MAX_PATH);
        // Extract the diretory
        var lPluginDir: String := Path.GetParentDirectory(String.FromCharArray(lModuleName));
        // Create and initialize the plugin
        TsmPlugin.Instance := new TsmPluginClass(lPluginDir);
        result := TsmPlugin.Instance.Initialize;
        if not result then TsmPlugin.Instance := nil;
      end;

      DLL_PROCESS_DETACH:
        TsmPlugin.Instance := nil;
      DLL_THREAD_ATTACH:
        {Do nothing.} ;
      DLL_THREAD_DETACH:
        {Do nothing.};
    end;

    exit true;
  end;

end. 