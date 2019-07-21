namespace TsmPluginFx.Manager;

uses
  System.Text,
  System.Runtime.InteropServices,
  System.IO;

  [DllImport('kernel32.dll')]
  method LoadLibrary(aModulePath: not nullable String): IntPtr; external;
  
  [DllImport('kernel32.dll')]
  method GetProcAddress(aModule: IntPtr; aProcName: not nullable String): IntPtr; external;

  [DllImport('kernel32.dll')]
  method FreeLibrary(aModule: IntPtr): Boolean; external;

type
  GetEnabledMethod       = block(): [MarshalAs(UnmanagedType.I1)] Boolean;
  GetPluginInfoMethod    = block(aPluginInfo: StringBuilder; aSize: UInt32): UInt32;
  GetPluginNameMethod    = block(aPluginName: StringBuilder; aSize: UInt32): UInt32;
  GetPluginVersionMethod = block(aPluginVersion: StringBuilder; aSize: UInt32): UInt32;
  SetEnabledMethod       = block([MarshalAs(UnmanagedType.I1)] aValue: Boolean);
  
  ITsmPluginModule = interface
    property Enabled: Boolean write;
    property Info: String read;
    property Loaded: Boolean read;
    property Name: String read;
    property Path: String read;
    property Version: String read;
  end;
 
  TsmPluginModule = class(ITsmPluginModule)
  private
    fModule: IntPtr;
    fModulePath: String;
    fGetEnabledFuncPtr, fSetEnabledFuncPtr, fGetPluginInfoFuncPtr, fGetPluginNameFuncPtr, fGetPluginVersionFuncPtr: IntPtr;
  private
    _GetEnabled: GetEnabledMethod;
    _GetPluginInfo: GetPluginInfoMethod;
    _GetPluginName: GetPluginNameMethod;
    _GetPluginVersion: GetPluginVersionMethod;
    _SetEnabled: SetEnabledMethod;
  public
    constructor(aModulePath: not nullable String; aEnabled: Boolean := true);
    begin
      fModulePath := aModulePath;
      fModule := LoadLibrary(fModulePath);
      if fModule = IntPtr.Zero then exit;

      fGetEnabledFuncPtr       := GetProcAddress(fModule, 'GetEnabled');
      fGetPluginInfoFuncPtr    := GetProcAddress(fModule, 'GetPluginInfo');
      fGetPluginNameFuncPtr    := GetProcAddress(fModule, 'GetPluginName');
      fGetPluginVersionFuncPtr := GetProcAddress(fModule, 'GetPluginVersion');
      fSetEnabledFuncPtr       := GetProcAddress(fModule, 'SetEnabled');

      if fGetEnabledFuncPtr <> IntPtr.Zero then
        _GetEnabled := Marshal.GetDelegateForFunctionPointer<GetEnabledMethod>(fGetEnabledFuncPtr);

      if fGetPluginInfoFuncPtr <> IntPtr.Zero then
        _GetPluginInfo := Marshal.GetDelegateForFunctionPointer<GetPluginInfoMethod>(fGetPluginInfoFuncPtr);

      if fGetPluginNameFuncPtr <> IntPtr.Zero then
        _GetPluginName := Marshal.GetDelegateForFunctionPointer<GetPluginNameMethod>(fGetPluginNameFuncPtr);

      if fGetPluginVersionFuncPtr <> IntPtr.Zero then
        _GetPluginVersion := Marshal.GetDelegateForFunctionPointer<GetPluginVersionMethod>(fGetPluginVersionFuncPtr);

      if fSetEnabledFuncPtr <> IntPtr.Zero then
        _SetEnabled := Marshal.GetDelegateForFunctionPointer<SetEnabledMethod>(fSetEnabledFuncPtr);

      Enabled := aEnabled;
    end;

    finalizer;
    begin
      if fModule <> IntPtr.Zero then
        FreeLibrary(fModule);
    end;

    property Enabled: Boolean
      read require
        assigned(_GetEnabled);
      begin
        exit _GetEnabled();
      end
      write begin
        if assigned(_SetEnabled) then _SetEnabled(value);
      end;
    
    property Info: String
      read require
        assigned(_GetPluginInfo); 
      begin
        var lSize := _GetPluginInfo(nil, 0);
        var lStrBuilder := new StringBuilder(lSize);
        _GetPluginInfo(lStrBuilder, lStrBuilder.Capacity + 1);
        exit lStrBuilder.ToString;
      end;
    
    property Loaded: Boolean 
      read begin
        exit fModule <> IntPtr.Zero;
      end;

    property Name: String
      read require
        assigned(_GetPluginName);
      begin
        var lStrBuilder := new StringBuilder(256);
        _GetPluginName(lStrBuilder, lStrBuilder.Capacity + 1);
        exit lStrBuilder.ToString;
      end;

    property Version: String
      read require
        assigned(_GetPluginVersion);
      begin
        var lStrBuilder := new StringBuilder(256);
        _GetPluginVersion(lStrBuilder, lStrBuilder.Capacity + 1);
        exit lStrBuilder.ToString;
      end;

    property Path: String read fModulePath;
  end;

end.