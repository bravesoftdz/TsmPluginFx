{/*! 
     Provides interface for vehicle monitor manager.
     
     \modified    2019-07-09 14:37pm
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses 
  rtl;

type
  VehicleMonitorManager = public static class  
  private    
    const DllName = 'VehicleMonitorManager.dll';
  public 
    [DllImport(DllName, EntryPoint := 'CreateVehicleMonitor')]
    [CallingConvention(CallingConvention.Stdcall)]
    class method CreateVehicleMonitor(aVehicleMonitorName: LPWSTR; aUserVehicleDllName: LPWSTR): ^Void; external;
    
    [DllImport(DllName, EntryPoint := 'RegisterVehicleMonitor')]
    [CallingConvention(CallingConvention.Stdcall)]
    class method RegisterVehicleMonitor(aMonitor: ^Void): Boolean; external;

    [DllImport(DllName, EntryPoint := 'UnregisterVehicleMonitor')]
    [CallingConvention(CallingConvention.Stdcall)]
    class method UnregisterVehicleMonitor(aMonitor: ^Void): Boolean; external;
    
    [DllImport(DllName, EntryPoint := 'DeleteVehicleMonitor')]
    [CallingConvention(CallingConvention.Stdcall)]
    class method DeleteVehicleMonitor(aMonitor: ^Void); external;
  end;

end.