#if !defined(_VEH_MONITOR_MANAGER_DLL_INTERFACE_)
#define _VEH_MONITOR_MANAGER_DLL_INTERFACE_

#include <windows.h>

namespace TsmPluginFx {
namespace VehicleMonitor {

extern "C" {
   _declspec(dllexport) void* _stdcall CreateVehicleMonitor(LPWSTR aVehicleMonitorName, LPWSTR aUserVehicleDllName);
   _declspec(dllexport) bool _stdcall RegisterVehicleMonitor(void* aMonitor);
   _declspec(dllexport) bool _stdcall UnregisterVehicleMonitor(void* aMonitor);
   _declspec(dllexport) void _stdcall DeleteVehicleMonitor(void* aMonitor);
}

}
}

#endif
