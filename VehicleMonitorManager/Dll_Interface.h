#if !defined(_VEH_MONITOR_MANAGER_DLL_INTERFACE_)
#define _VEH_MONITOR_MANAGER_DLL_INTERFACE_

#include <windows.h>

namespace Tsm {
namespace Plugin {
namespace Core {

extern "C" {

    /*!
        Creates vehicle monitor

        \param  parameter1  Name of the vehicle monitor.
        \param   aUserVehicleDllName Name of the user vehicle DLL.

        \returns Null if it fails, else the new vehicle monitor.
     */
    _declspec(dllexport) void* _stdcall CreateVehicleMonitor(LPWSTR aVehicleMonitorName, LPWSTR aUserVehicleDllName);

    /*!
        Registers the vehicle monitor described by aMonitor

        \param  The monitor to register.

        \returns True if it succeeds, false if it fails.
     */
    _declspec(dllexport) bool _stdcall RegisterVehicleMonitor(void* aMonitor);

    /*!
        Unregisters the vehicle monitor described by aMonitor

        \param  The monitor to unregister.

        \returns True if it succeeds, false if it fails.
     */
    _declspec(dllexport) bool _stdcall UnregisterVehicleMonitor(void* aMonitor);

    /*!
        Deletes the vehicle monitor described by aMonitor

        \param  The monitor to delete.
     */
    _declspec(dllexport) void _stdcall DeleteVehicleMonitor(void* aMonitor);
}

}
}
}


#endif
