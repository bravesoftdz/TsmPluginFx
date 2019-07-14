{/*! 
     Provides Dll entry point and exported functions.

     \modified    2019-07-09 13:40pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

interface 

uses
  rtl;

  {/*! Invokes a user-supplied editor for editing plugin parameters. */}
  [SymbolName('OpenParameterEditor'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method OpenParameterEditor;


  {/*! 
       Activates the plugin. An associated user interface may be generated and inserted into
       the main user interface of the hosting microsimulator. 
    */}
  [SymbolName('ActivatePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method ActivatePlugin;


  {/*! 
       Deactivates the plugin. An associated user interface, if any, will be removed from
       the main user interface of the hosting microsimulator. 
    */}
  [SymbolName('DeactivatePlugin'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method DeactivatePlugin;


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
  method GetPluginInfo(aPluginInfo: LPWSTR := nil; aSize: DWORD): DWORD;

  {/*! 
       Returns a newly created user vehicle pointer.
  
       \param  aID  Vehicle ID.  
       \param  aProperty  Vehicle property.
       \param  aFlags Vehicle monitor option.
    */}
  [SymbolName('CreateUserVehicle'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method CreateUserVehicle(aID: LongInt; aProperty: ^VehicleProperty; aFlags: ^VehicleMonitorOption): ^UserVehicle;

  {/*! Dll entry point. */}
  [SymbolName('__elements_dll_main', ReferenceFromMain := true)]
  method DllMain(aModule: rtl.HMODULE; aReason: rtl.DWORD; aReserved: ^Void): Boolean;


implementation

  method OpenParameterEditor;
  begin
    TsmPlugin.Singleton.OpenParameterEditor;
  end;

  method ActivatePlugin;
  begin
    TsmPlugin.Singleton.Active := true;
  end;

  method DeactivatePlugin;
  begin
    TsmPlugin.Singleton.Active := false;
  end;

  method GetPluginInfo(aPluginInfo: LPWSTR := nil; aSize: DWORD): DWORD;
  begin
    with aDesc := TsmPlugin.Singleton.Description do begin
      if not assigned(aPluginInfo) then 
        exit (aDesc.Length + 1);
      
      var lInfo: array of Char := aDesc.ToCharArray;
      var lSize: DWORD := Math.Min(aSize, aDesc.Length + 1);
      aPluginInfo[lSize] := #0;
      memcpy(aPluginInfo, lInfo, sizeOf(Char) * (lSize - 1));
      
      exit lSize;
    end;
  end;

  method CreateUserVehicle(aID: LongInt; aProperty: ^VehicleProperty; aFlags: ^VehicleMonitorOption): ^UserVehicle;
  begin
    if assigned(TsmPlugin.Singleton.VehicleFactory) then
      result := TsmPlugin.Singleton.VehicleFactory.CreateUserVehicle(aID, aProperty, aFlags);
  end;

  method DllMain(aModule: rtl.HMODULE; aReason: rtl.DWORD; aReserved: ^Void): Boolean;
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