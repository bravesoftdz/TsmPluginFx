#include "CustomVehicleMonitor.h"

namespace TsmPluginFx {
namespace VehicleMonitor {

CustomVehicleMonitor::CustomVehicleMonitor(LPWSTR aName, LPWSTR aUserVehicleDllName)
{
   wstring lName = aName;
   _name = SysAllocStringLen(lName.data(), (UINT)lName.length());
   _userVehicleDllName = aUserVehicleDllName;
   _userVehicleDllHandle = LoadLibraryW(_userVehicleDllName.data());

   if (_userVehicleDllHandle) {
      _createUserVehicle = (CreateUserVehicleFunction)GetProcAddress(_userVehicleDllHandle, "CreateUserVehicle");

      if (!_createUserVehicle) {
         #if defined(_DEBUG)
         OutputDebugString("GetProcAddress failed for symbol \"CreateUserVehicle\".\n");
         #endif
      }
   }
   else {
      #if defined(_DEBUG)
      OutputDebugStringW((L"Failed to load user vehicle dll" + _userVehicleDllName).data());
      #endif
   }
};

CustomVehicleMonitor::~CustomVehicleMonitor()
{
   SysReleaseString(_name);
};

IUserVehicle* CustomVehicleMonitor::AttachVehicle(long id, const SVehicleProperty& vehicleProperty, unsigned long* flags)
{
   IUserVehicle* userVehicle = nullptr;

   if (_createUserVehicle) {
      userVehicle = _createUserVehicle(id, vehicleProperty, flags);
   }

   return userVehicle;
};

bool CustomVehicleMonitor::UserVehicleDllLoaded()
{
   return (nullptr != _userVehicleDllHandle) && (nullptr != _createUserVehicle);
};

}
}