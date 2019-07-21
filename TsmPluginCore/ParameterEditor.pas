{/*! 
     Provides COM interface to TransModeler's parameter editor.  

     \modified    2019-07-03 10:20am
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses
  rtl,
  RemObjects.Elements.RTL;

const
  ParameterEditorMajorVersion = 3;
  ParameterEditorMinorVersion = 0;

const
 LIBID_ParameterEditor: String = '{EB854259-C780-1130-97DF-036698AF3825}';
 IID_IParametermEditor: String = '{09A6D596-97C5-1130-B40B-487B9F57A4AA}';
 CLASS_ParameterEditor: String = '{B8108142-418F-1130-A558-7562FF2FD592}';

type
  {/*!
       TransModeler project parameters may be stored in three seperate pml files:
       	  - Base pml file
       	       A mandatory file that defines default values and layout of all the parameters.
       	  - Secondary pml file
       	       An optional file that only saves values differing from the base file. This file
               can be used to save user-specific parameter values.
          - Third pml file
               An optional file that only saves values differing from the secondardary file.
               This file can be used to save project-specific parameter values.

        A filter can be applied - it uses item lables to locate items.
    */}
  [COM, Guid(IID_IParametermEditor)]
  IParameterEditor = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Edit(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Show(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EditPage(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aPage      : OleString := String.Empty;
        aRoot      : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ShowPage(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aPage      : OleString := String.Empty;
        aRoot      : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EditPageInGroup(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aRoot      : OleString := String.Empty;
        aGroup     : OleString := String.Empty;
        aPage      : OleString := String.Empty
     ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ShowPageInGroup(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aRoot      : OleString := String.Empty;
        aGroup     : OleString := String.Empty;
        aPage      : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EditPages(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aRoot      : OleString := String.Empty;
        aFilter    : OleString := String.Empty
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Open(
        aBase      : OleString;
        aSecondary : OleString := String.Empty;
        aThird     : OleString := String.Empty;
        aRoot      : OleString := String.Empty;
        aGroup     : OleString := String.Empty;
        aPage      : OleString := String.Empty;
        aEditable  : LongInt   := 0;
        aModaless  : LongInt   := 0;
        aSingle    : LongInt   := 0
    ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetCurrentPageName(
        out aPage: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SelectItem(
        aItem: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetItemStringValue(
        aItem: OleString;
        aValue: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetItemAttribute(
        aItem: OleString;
        aColumn: Int16;
        aAttribute: OleString;
        aValue: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetArrayStringValue(
        aItem: OleString;
        aColumn: Int16;
        aRow: Int16;
        aValue: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetItemStringValue(
        aItem: OleString;
        out aValue: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetArrayStringValue(
        aItem: OleString;
        aColumn: Int16;
        aRow: Int16;
        out aValue: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddTableRow(
        aItem: OleString;
        aLabel: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method DeleteTableRow(
        aItem: OleString;
        aRow: Int16): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ViewFile(
        aFileName: OleString;
        aTitle: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ViewFileEx(
        aFileName: OleString;
        aTitle: OleString;
        aColumns: LongInt;
        aRows: LongInt;
        aTimerSpeed: LongInt): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Convert(
        aFileName: OleString;
        aBase: OleString;
        aSecondary: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Apply: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Close(
        aOK: LongInt): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetExitStatus(
        out aStatus: OleString): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetModified(
        aModified: LongInt): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Modified(
        out aValue: VARIANT_BOOL): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Modified(
        aValue: VARIANT_BOOL): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ShowHidden(
        aShowHidden: LongInt): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetReFormat(
        aReFormat: LongInt): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetVersion(
        out aVersion: Double): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AllowDefault(
        aValue: LongInt): HRESULT;
  end;

  CoParameterEditor = class
  public
    class method Create: IParameterEditor;
    begin
      result := CreateComObject(CLASS_ParameterEditor) as IParameterEditor;
    end;
  end;

end.