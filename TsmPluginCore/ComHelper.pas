{/*! 
     Provides COM helper functions.
     
     \modified    2019-07-02 11:19am
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses
  rtl;

type
  VARIANT_BOOL = public Int16;
const
  VARIANT_TRUE   = $FFFF;
  VARIANT_FALSE  = $0000;

type
  EOleSysError = public class(Exception)
  private
    fErrorCode: HRESULT;
    fHelpContext: Integer;
  public
    constructor(const aMessage: String; aErrorCode: HRESULT; aHelpContext: Integer);
    begin
      var lMsg := aMessage;
      fHelpContext := aHelpContext;
      fErrorCode := aErrorCode;

      if String.IsNullOrEmpty(lMsg) then begin
        lMsg := SysErrorMessage(aErrorCode);
        if String.IsNullOrEmpty(lMsg) then
          lMsg := String.Format('Ole error {0:X8}', [aErrorCode]);
      end;

      inherited(lMsg);
    end;
  public
    property ErrorCode: HRESULT read fErrorCode write fErrorCode;
    property HelpContext: Integer read fHelpContext;
  end;

  method CreateComObject(const aClassID: String): IUnknown;
  begin
    var IID_IUnknown: GUID := guidOf(IUnknown);
    var CLSID: GUID := new RemObjects.Elements.System.Guid(aClassID);

    OleCheck(CoCreateInstance(
      @CLSID,
      nil,
      DWORD(CLSCTX.CLSCTX_INPROC_SERVER or CLSCTX.CLSCTX_LOCAL_SERVER),
      @IID_IUnknown,
      (^LPVOID)(@result)));
  end;

  method OleError(aErrorCode: HRESULT);
  begin
    raise new EOleSysError(nil, aErrorCode, 0);
  end;

  method OleCheck(aHRESULT: HRESULT);
  begin
    if not Succeeded(aHRESULT) then
      OleError(aHRESULT);
  end;

  method SysErrorMessage(aErrorCode: Cardinal; aModuleHandle: HLOCAL := 0): String;
  begin
    var lpBuffer: LPWSTR;
    var lFlags: DWORD := FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS or
      FORMAT_MESSAGE_ARGUMENT_ARRAY or FORMAT_MESSAGE_ALLOCATE_BUFFER;

    if aModuleHandle <> nil then
      lFlags := lFlags or FORMAT_MESSAGE_FROM_HMODULE;

    try
      var lLen: DWORD := FormatMessage(
        lFlags,
        aModuleHandle,
        aErrorCode,
        0,
        (LPWSTR)(@lpBuffer),
        0,
        nil);

      while (lLen > 0) and ((lpBuffer[lLen - 1] <= #32) or (lpBuffer[lLen - 1] = '.')) do
        dec(lLen);

      result := String.FromPChar(lpBuffer, lLen);
    finally
      LocalFree(HLOCAL(lpBuffer^));
    end;
  end;

  method Succeeded(aHRESULT: HRESULT): Boolean;
  begin
    result := aHRESULT and $80000000 = 0;
  end;

  method Failed(aHRESULT: HRESULT): Boolean;
  begin
    result := aHRESULT and $80000000 <> 0;
  end;

  method ResultCode(aHRESULT: HRESULT): Integer;
  begin
    result := aHRESULT and $0000FFFF;
  end;

  method ResultFacility(aHRESULT: HRESULT): Integer;
  begin
    result := (aHRESULT shr 16) and $00001FFF;
  end;

  method ResultSeverity(aHRESULT: HRESULT): Integer;
  begin
    result := aHRESULT shr 31;
  end;

  method MakeResult(aSeverity, aFacility, aCode: Integer): HRESULT;
  begin
    result := (aSeverity shl 31) or (aFacility shl 16) or aCode;
  end;

  method InterfaceConnect(const aSource: IUnknown; var IID: GUID; const aSink: IUnknown; var aConnection: DWORD);
  begin
    var lCP: IConnectionPoint;
    var lCPC: IConnectionPointContainer := aSource as IConnectionPointContainer;

    if Succeeded(lCPC.FindConnectionPoint(@IID, @lCP)) then
      lCP.Advise(aSink, @aConnection);
  end;

  method InterfaceDisconnect(const aSource: IUnknown; var IID: GUID; aConnection: DWORD);
  begin
    var lCP: IConnectionPoint;
    var lCPC: IConnectionPointContainer := aSource as IConnectionPointContainer;

    if Succeeded(lCPC.FindConnectionPoint(@IID, (^IConnectionPoint)(@lCP))) then
      lCP.Unadvise(aConnection);
  end;

  method StringToLPWSTR(aSource: not nullable String; aDestination: LPWSTR; aSize: DWORD): DWORD;
  begin
    if not assigned(aDestination) then exit (aSource.Length + 1);  
    
    var lChars: array of Char := aSource.ToCharArray;
    var lSize: DWORD := Math.Min(aSize, aSource.Length + 1);
  
    aDestination[lSize] := #0;
    memcpy(aDestination, lChars, sizeOf(Char) * (lSize - 1));      
  
    exit lSize;  
 end;

end.