#if !defined(_CUSTOM_VEHICLE_MONITOR_)
#define _CUSTOM_VEHICLE_MONITOR_

#include <vector>
#include <windows.h>
#include <VehicleMonitor.h>
#include <string>

using namespace std;

namespace Tsm {
namespace Plugin {
namespace Core {

/*! Defines a callback function type that returns IUserVehicle pointer. */
typedef IUserVehicle* (CALLBACK* CreateUserVehicleFunction)(
   long id,
   const SVehicleProperty& vehicleProperty,
   unsigned long* flags);

/*! A custom vehicle monitor that uses user vehicle factory defined in an external DLL. */
class CustomVehicleMonitor: public CUserVehicleMonitor
{
public:

    /*!
        Constructor

        \param aName                The name of the monitor.
        \param aUserVehicleDllName  Name of the external user vehicle DLL providing user vehicle
         factory.
     */
   CustomVehicleMonitor(LPWSTR aName, LPWSTR aUserVehicleDllName);
   virtual ~CustomVehicleMonitor();

   /*!
       Attach vehicle

       \param          id                The identifier.
       \param          vehicleProperty   The vehicle property.
       \param [in,out] flags             If non-null, the flags.

       \returns  Null if it fails, else a pointer to an IUserVehicle.
    */
   virtual IUserVehicle* AttachVehicle(long id, const SVehicleProperty& vehicleProperty, unsigned long* flags);

   /*!
       Gets the name of the monitor

       \returns  The subject monitor's name.
    */
   inline virtual const BSTR GetName() const
   {
      return _name;
   };

   /*!
       Determines if the external dll has been successfully loaded. The dll provides a user vehicle
       factory for generating user vehicles.

       \returns  True if the dll has been loaded, false otherwise.
    */
   bool UserVehicleDllLoaded();
private:
   BSTR _name = nullptr;
   wstring _userVehicleDllName;
   HINSTANCE _userVehicleDllHandle = nullptr;
   CreateUserVehicleFunction _createUserVehicle = nullptr;
};

}  // Namespace Core
}  // Namespace Plugin
}  // Namespace Tsm
#endif