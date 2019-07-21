{/*! 
     Provides Dll entry point and exported functions.

     \modified    2019-07-19 13:04
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses
  rtl;

  {/*! Invokes a user-supplied editor for editing plugin parameters. */}
  [SymbolName('OpenParameterEditor'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method OpenParameterEditor;
  begin
    TsmPlugin.Singleton.OpenParameterEditor;
  end;

  {/*! 
       Activates the plugin. An associated user interface may be generated and inserted into
       the main user interface of the hosting microsimulator. 
    */}
  [SymbolName('EnablePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method EnablePlugin;
  begin
    SetEnabled(true);
  end;

  {/*! 
       Deactivates the plugin. An associated user interface, if any, will be removed from
       the main user interface of the hosting microsimulator. 
    */}
  [SymbolName('DisablePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method DisablePlugin;
  begin
    SetEnabled(false);
  end;

  {/*! 
       Returns a descriptive string about the plugin.
  
       \param  aPluginInfo
          A 0-indexed char pointer referencing a null-terminated string. If nil, then aSize will be ingored,
          and return value is the actual size of the plugin info string plus 1. The caller
          should allocate enough memory based on the returned size, and call this function again,
          with a non-null pointer.
       \param aSize
          Size of the memory space allocated for aPluginInfo, including the null character.

       \remark The caller is responsible for allocating and releasing memory for aPluginInfo.
       \returns  Actual number of characters copied to aPluginInfo, including the null character.
    */}
  [SymbolName('GetPluginInfo'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetPluginInfo(aPluginInfo: LPWSTR; aSize: DWORD): DWORD;
  begin
    exit StringToLPWSTR(TsmPlugin.Singleton.PluginInfo, aPluginInfo, aSize);
  end;

  [SymbolName('GetPluginName'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetPluginName(aPluginName: LPWSTR; aSize: DWORD): DWORD;
  begin
    exit StringToLPWSTR(TsmPlugin.Singleton.PluginName, aPluginName, aSize);
  end;

  [SymbolName('GetPluginVersion'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetPluginVersion(aPluginVersion: LPWSTR; aSize: DWORD): DWORD;
  begin
    exit StringToLPWSTR(TsmPlugin.Singleton.PluginVersion, aPluginVersion, aSize);
  end;

  [SymbolName('GetEnabled'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetEnabled: Boolean;
  begin
    exit TsmPlugin.Singleton.Enabled;
  end;

  [SymbolName('SetEnabled'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method SetEnabled(aValue: Boolean);
  begin
    TsmPlugin.Singleton.Enabled := aValue;
  end;

  {/*! 
       Returns a newly created user vehicle pointer.
  
       \param  aID  Vehicle ID.  
       \param  aProperty  Vehicle property.
       \param  aFlags Vehicle monitor option.
    */}
  [SymbolName('CreateUserVehicle'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method CreateUserVehicle(aID: LongInt; aProperty: ^VehicleProperty; aFlags: ^VehicleMonitorOption): ^UserVehicle;
  begin
    if assigned(TsmPlugin.Singleton.VehicleFactory) then
      result := TsmPlugin.Singleton.VehicleFactory.CreateUserVehicle(aID, aProperty, aFlags);
  end;

  {/*! Dll entry point. */}
  [SymbolName('__elements_dll_main', ReferenceFromMain := true)]
  method DllMain(aModule: HMODULE; aReason: DWORD; aReserved: ^Void): Boolean;
  begin
    method GetPluginDllPath: String; 
    begin
      var lBuffer: array of Char := new Char[MAX_PATH];
      GetModuleFileName(aModule, lBuffer, MAX_PATH); 
      exit String.FromCharArray(lBuffer);
    end;

    case aReason of
      DLL_PROCESS_ATTACH:
        begin  
          var lPluginDir: String := Path.GetParentDirectory(GetPluginDllPath);
          exit TsmPlugin.CreateSingleton(lPluginDir);
        end;
        
      DLL_PROCESS_DETACH:
        exit true;
      
      DLL_THREAD_ATTACH:
        exit true;
      
      DLL_THREAD_DETACH:
        exit true;
    end;
  end;

end. 