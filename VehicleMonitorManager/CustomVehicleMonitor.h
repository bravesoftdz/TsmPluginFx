#if !defined(_CUSTOM_VEHICLE_MONITOR_)
#define _CUSTOM_VEHICLE_MONITOR_

#include <vector>
#include <windows.h>
#include <VehicleMonitor.h>
#include <string>

using namespace std;

namespace TsmPluginFx {
namespace VehicleMonitor {

typedef IUserVehicle* (CALLBACK* CreateUserVehicleFunction)(
   long id,
   const SVehicleProperty& vehicleProperty,
   unsigned long* flags);

class CustomVehicleMonitor: public CUserVehicleMonitor
{
public:
   CustomVehicleMonitor(LPWSTR aName, LPWSTR aUserVehicleDllName);
   virtual ~CustomVehicleMonitor();
   virtual IUserVehicle* AttachVehicle(long id, const SVehicleProperty& vehicleProperty, unsigned long* flags);

   inline virtual const BSTR GetName() const
   {
      return _name;
   };

   bool UserVehicleDllLoaded();
private:
   BSTR _name = nullptr;
   wstring _userVehicleDllName;
   HINSTANCE _userVehicleDllHandle = nullptr;
   CreateUserVehicleFunction _createUserVehicle = nullptr;
};

}
}
#endif