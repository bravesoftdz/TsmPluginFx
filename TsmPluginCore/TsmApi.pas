{/*! 
     Provides COM interface of TransModeler's TsmApi.  
        
     \modified    2019-07-01 16:00pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  rtl;

const
  TsmApiMajorVersion = 1;
  TsmApiMinorVersion = 0;

const
 LIBID_TsmApi           : String = '{1DA9E83D-B7FF-49D2-B3FC-49AE2CEE10F7}';
 IID__ISimulationEvents : String = '{9B3B22CA-9E51-4124-9B05-21A1FE538E32}';
 IID__ISensorEvents     : String = '{5683D24E-0FB1-480D-A153-E78C91BC8047}';
 IID__ISignalEvents     : String = '{5683D24E-0FB1-480D-A154-E78C91BC8047}';
 IID__IVehicleEvents    : String = '{266A8735-597B-45BD-90CB-80796741BD64}';
 IID_ITsmVehicle        : String = '{DF992021-08C4-45C9-B1CC-34E2F22D71EE}';
 IID_ITsmObject         : String = '{0D99A556-F2CE-47BB-B292-D72C4EE3AE0D}';
 IID_ITsmLink           : String = '{BD329B79-5C12-4477-A453-90B838EF36F2}';
 IID_ITsmCollection     : String = '{C9949A42-BC30-4713-B072-8596AE67DF10}';
 IID_ITsmSegments       : String = '{758CEC73-08EB-4907-B941-F115EF3F93AB}';
 IID_ITsmSegment        : String = '{51F0EA1F-7645-470D-AA1B-B442FAE9FD8E}';
 IID_ITsmLanes          : String = '{BAC1C49F-0218-48A3-9BCC-026E2F20A67B}';
 IID_ITsmLane           : String = '{81AF5B60-3800-4290-B51C-BE15FB2515E1}';
 IID_ITsmConnector      : String = '{D3A0E4C9-5D65-404D-B7C2-0B25D48B08E3}';
 IID_ITsmConnectors     : String = '{C4A1CECC-E566-482B-B427-A114A4FA69BD}';
 IID_ITsmSensorStations : String = '{A7602159-378B-46DD-920F-189048B45AC5}';
 IID_ITsmSensorStation  : String = '{92FFCB56-F9F4-4DC3-B0EF-64A109278820}';
 IID_ITsmSensors        : String = '{75E00364-FD5A-4633-A6CF-AB18E5061867}';
 IID_ITsmSensor         : String = '{64BACF71-2686-404F-B379-F4CA81F270B7}';
 IID_ITsmVehicles       : String = '{62525380-FD3B-4E39-BA2E-334CD9828194}';
 IID_ITsmNode           : String = '{F4AA34C9-0DA6-47DD-9E9F-C1BA14F30C59}';
 IID_ITsmSignals        : String = '{F87CE8DD-D4A5-447D-A827-80255E8D70F8}';
 IID_ITsmSignal         : String = '{A5345C5C-9C50-4A28-BC55-0A3001E6789D}';
 IID_ITsmAttributes     : String = '{4D6F5D2F-4E79-4151-BCB9-8E67A0EB4DA6}';
 IID_ITsmPath           : String = '{63F34616-46C8-4BD9-A54B-363ECE4339DC}';
 IID_ITsmRoute          : String = '{41931BF9-CF69-40DB-A57B-BA9BA9A0322D}';
 IID_ITsmStops          : String = '{086DC5FC-3734-438E-9D57-557C4D598324}';
 IID_ITsmStop           : String = '{342A66DE-B022-47C7-96C5-3B65039C350E}';
 IID_ITsmApplication    : String = '{758966B7-BDFD-4D3D-AA50-18DF799BB435}';
 IID_ITsmNetwork        : String = '{D57DE796-602F-4EB9-B441-7ECB00FC42A2}';
 IID_ITsmNodes          : String = '{ECA7B86F-60D4-4FBC-ACB7-AE87A0FD7887}';
 IID_ITsmLinks          : String = '{7CFD586F-6BB3-4E5C-8CD9-4CF6C10E1570}';
 IID_ITsmTrafficManager : String = '{8276A6F2-F679-49B5-8356-E904E89D4073}';
 IID_ITsmController     : String = '{BE421016-C4CA-42CD-AA0D-1499D10BF9C5}';
 IID_ITsmPhases         : String = '{488A51F1-9401-464C-B6B1-8AA4A8256421}';
 IID_ITsmPhase          : String = '{F078F3F1-6476-445A-9796-D535D0F3DCDC}';
 IID_ITsmStages         : String = '{9C0EE7A4-B717-4335-B2E2-B610369F7800}';
 IID_ITsmStage          : String = '{5FAC1421-56A5-4C64-BABB-B4BA2668FB80}';
 IID_ITsmControllers    : String = '{41DFF515-50A5-4BF0-A160-255C440844B1}';
 IID_ITsmHotEntrance    : String = '{5FAC1421-56A5-4C64-BABB-B4BA2668FBA1}';
 IID_ITsmHotSection     : String = '{5FAC1421-56A5-4C64-BABB-B4BA2668FBA3}';
 IID_ITsmHotSections    : String = '{9C0EE7A4-B717-4335-B2E2-B610369F78A4}';
 IID_ITsmHotEntrances   : String = '{9C0EE7A4-B717-4335-B2E2-B610369F78A1}';
 IID_ITsmTollPlaza      : String = '{AA1AAFEA-E59E-4A16-98DE-A17A5798BD8C}';
 IID_ITsmTollBooth      : String = '{E1295D31-13CE-4323-8A8F-28C3BEE9873D}';
 IID_ITsmTollBooths     : String = '{E7604F19-753A-4279-ABB6-607871CE5968}';
 IID_ITsmToll           : String = '{1C75CA53-88EE-4BC0-B483-8F3654086875}';
 IID_ITsmTolls          : String = '{D8480532-4B3C-4AF9-BAE3-2B2EAD6DF137}';
 IID_ITsmTollPlazas     : String = '{472AEC28-7441-4307-97A8-E6FD02355188}';
 IID_ITsmRouter         : String = '{2711725D-AF41-4B3B-A23C-C00501CB24E2}';
 IID_ITsmTransit        : String = '{D490F99E-1B3C-4E90-90B7-EE5C9A423DA5}';
 IID_ITsmService        : String = '{37B54C69-1721-44E5-BF7A-D10D42551F5E}';
 CLASS_TsmApplication   : String = '{AA2FE82A-2676-4189-9E91-7D8CEC676E20}';
 CLASS_TsmService       : String = '{E97A4B4F-EBD4-4BE5-800B-4AA1BB31ABAE}';
 CLASS_TsmAttributes    : String = '{2761967A-735B-4FAA-9554-04A8E75D5726}';
 CLASS_TsmNetwork       : String = '{0F81F1E0-AD1C-4A6B-B11F-967AE7FE0DC3}';
 CLASS_TsmNode          : String = '{AC87F2AB-AACD-4800-813E-BC7AE233FDD9}';
 CLASS_TsmNodes         : String = '{2436498F-08B6-4F53-B4F4-99469220BFB0}';
 CLASS_TsmLink          : String = '{B1AA9487-5F56-49C0-860F-CD05CDAEC780}';
 CLASS_TsmLinks         : String = '{C49FF85F-CECC-474B-BCA5-7B636ACC9683}';
 CLASS_TsmSegment       : String = '{C4B0256B-39F4-44FF-9425-758C993A3EFB}';
 CLASS_TsmSegments      : String = '{3B43D6FF-9BE2-458E-B71D-D90FE655978F}';
 CLASS_TsmLane          : String = '{10EDE541-0C1F-4280-A550-FF396AC6E99F}';
 CLASS_TsmLanes         : String = '{00B4E1FC-AB5D-45E1-99DA-A9EA63E71794}';
 CLASS_TsmConnector     : String = '{CC5F098D-3EB3-4B6E-868A-537D05D12F80}';
 CLASS_TsmConnectors    : String = '{08FA166D-6E97-433E-8FAE-DADA31923F69}';
 CLASS_TsmSensor        : String = '{24B84964-C848-4FF0-92AC-D1354E113CC5}';
 CLASS_TsmSensors       : String = '{6F024354-3400-41AB-B665-71D844DA606B}';
 CLASS_TsmSensorStation : String = '{BD4F9085-2E6D-4F02-A69B-E06FF967FA1D}';
 CLASS_TsmSensorStations: String = '{10054C01-5DF7-4929-9104-FFC268BDCD22}';
 CLASS_TsmSignal        : String = '{A1B4A98A-9A84-4DF7-98AB-82A84C58CEE2}';
 CLASS_TsmSignals       : String = '{6395FB30-EB69-47C3-992F-D82B59E815DC}';
 CLASS_TsmVehicle       : String = '{52915AC7-12D2-4F4E-B0FA-381936ED55E4}';
 CLASS_TsmVehicles      : String = '{051C7F4D-5E8B-4C2A-99F8-15A789299376}';
 CLASS_TsmTrafficManager: String = '{9FAB203D-EBD5-46FA-8673-E0149E45683F}';
 CLASS_TsmController    : String = '{B615E202-85A9-4BB5-9D43-EC6BF1135744}';
 CLASS_TsmControllers   : String = '{01AB2EFD-936D-4D69-8513-E7BB74D84B89}';
 CLASS_TsmPhase         : String = '{A7CDA36B-56F8-4C0D-B9B0-79F35B8BAAD0}';
 CLASS_TsmPhases        : String = '{AEB4566F-8D39-4D5F-90C9-57C1559D8092}';
 CLASS_TsmStage         : String = '{F9D57D42-5314-4964-9075-6702ED2FEED7}';
 CLASS_TsmStages        : String = '{728DDECE-1F65-4986-84C4-365A34BCF512}';
 CLASS_TsmHotEntrance   : String = '{F9D57D42-5314-4964-9075-6702ED2FEEA1}';
 CLASS_TsmHotEntrances  : String = '{728DDECE-1F65-4986-84C4-365A34BCF5A2}';
 CLASS_TsmHotSection    : String = '{F9D57D42-5314-4964-9075-6702ED2FEEA3}';
 CLASS_TsmHotSections   : String = '{728DDECE-1F65-4986-84C4-365A34BCF5A4}';
 CLASS_TsmTollPlaza     : String = '{67836913-E261-4368-829B-646E583B2B25}';
 CLASS_TsmTollPlazas    : String = '{2476254E-504C-41B6-B63F-C4DED824C3BE}';
 CLASS_TsmTollBooth     : String = '{D5C210E8-DBA0-42AF-AC00-3FB6AF115374}';
 CLASS_TsmTollBooths    : String = '{0D888FE2-1855-43B0-90C0-235F2FD2DFDB}';
 CLASS_TsmToll          : String = '{33C90824-99D1-4E6D-A66B-73FF7B59D99C}';
 CLASS_TsmTolls         : String = '{372B48BA-3842-4FCE-B220-4E30D7108AF0}';
 CLASS_TsmRouter        : String = '{E43EE6A9-CFB5-45D9-B760-09A798F30467}';
 CLASS_TsmPath          : String = '{7ECE64EC-21A8-4C48-82A7-D891EB70B4D7}';
 CLASS_TsmTransit       : String = '{1022C0D5-FFF7-49BD-8063-65440CC21E7B}';
 CLASS_TsmRoute         : String = '{FE6F92C0-8615-4BAC-AAB7-880AF11819EE}';
 CLASS_TsmStop          : String = '{5853FDE6-6259-495C-A20B-DE64BC901A72}';
 CLASS_TsmStops         : String = '{89014D44-723F-491D-83CC-52F87C8B13C9}';

type
  TsmRunType = public UInt32;
const
  RUNTYPE_PLAYBACK               = $00000000;
  RUNTYPE_EMULATION              = $00000001;
  RUNTYPE_ONE                    = $00000002;
  RUNTYPE_BATCH                  = $00000003;
  RUNTYPE_DTA                    = $00000004;
  RUNTYPE_CALIBRATION            = $00000005;

type
  TsmState = public UInt32;
const
  STATE_ERROR                    = $FFFFFFFC;
  STATE_CANCELED                 = $FFFFFFFD;
  STATE_NOTSTARTED               = $FFFFFFFE;
  STATE_DONE                     = $FFFFFFFF;
  STATE_RUNNING                  = $00000000;
  STATE_PAUSED                   = $00000001;
  STATE_PRELOADED                = $00000009;
  STATE_UNKNOWN                  = $00000063;

type
  TsmControlClass = public UInt32;
const
  UNKNOWN_CONTROL                = $FFFFFFF7;
  SIGNAL_CONTROL                 = $00000000;
  INTERSECTION_CONTROL           = $00000001;
  LANEACCESS_CONTROL             = $00000002;

type
  TsmHotState = public UInt32;
const
  HOT_NONE                       = $00000000;
  HOT_YES                        = $00000001;
  HOT_ON                         = $00000002;

type
  TsmLocationType = public UInt32;
const
  LOCATION_NONE                  = $00000000;
  LOCATION_NODE                  = $00000001;
  LOCATION_LINK                  = $00000002;
  LOCATION_CENTROID              = $00000003;

type
  TsmFidelity = public UInt32;
const
  FIDELITY_NONE                  = $00000000;
  FIDELITY_MICRO                 = $00000001;
  FIDELITY_MESO                  = $00000002;
  FIDELITY_MACRO                 = $00000003;

type
  TsmDirection = public UInt32;
const
  TSM_EAST                       = $00000000;
  TSM_SOUTH                      = $00000001;
  TSM_WEST                       = $00000002;
  TSM_NORTH                      = $00000003;
  TSM_SOUTHEAST                  = $00000004;
  TSM_SOUTHWEST                  = $00000005;
  TSM_NORTHWEST                  = $00000006;
  TSM_NORTHEAST                  = $00000007;

type
  TsmTurn = public UInt32;
const
  TURN_ULEFT                     = $00000000;
  TURN_LEFT                      = $00000001;
  TURN_SLIGHTLEFT                = $00000002;
  TURN_STRAIGHT                  = $00000003;
  TURN_SLIGHTRIGHT               = $00000004;
  TURN_RIGHT                     = $00000005;
  TURN_URIGHT                    = $00000006;

type
  TsmConnectorType = public UInt32;
const
  CONNECTOR_ALL                  = $00000000;
  CONNECTOR_MERGE                = $00000001;
  CONNECTOR_DIVERGE              = $00000002;
  CONNECTOR_PARALLEL             = $00000003;

type
  TsmReversible = public UInt32;
const
  NEITHER_DIRECTION              = $00000000;
  AB_DIRECTION                   = $00000001;
  BA_DIRECTION                   = $00000002;
  SHARED                         = $00000003;

type
  TsmSide = public UInt32;
const
  NEITHER_SIDE                   = $00000000;
  RIGHT_SIDE                     = $00000001;
  LEFT_SIDE                      = $00000002;
  BOTH_SIDES                     = $00000003;

type
  TsmAuxiliary = public UInt32;
const
  AUX_NONE                       = $00000000;
  AUX_ACC                        = $00000001;
  AUX_DEC                        = $00000002;
  AUX_BOTH                       = $00000003;

type
  TsmHOV = public UInt32;
const
  SOV                            = $00000001;
  HOV2                           = $00000002;
  HOV3                           = $00000003;

type
  TsmAccess = public UInt32;
const
  ACCESS_ALLOWED                 = $00000000;
  ACCESS_PROHIBITED              = $00000001;
  ACCESS_RESERVED                = $00000002;

type
  TsmVALevel = public UInt32;
const
  VALEVEL_NONE                   = $00000000;
  VALEVEL_ACCELERATION           = $0000001A;
  VALEVEL_STEERING               = $0000001B;
  VALEVEL_PARTIAL                = $00000020;
  VALEVEL_CONDITIONAL            = $00000030;
  VALEVEL_HIGH                   = $00000040;
  VAEVELL_FULL                   = $00000050;

type
  TsmDetectionType = public UInt32;
const
 NONE_TYPE                       = $00000000;
 PRESENCE_TYPE                   = $00000001;
 PULSE_TYPE                      = $00000002;

type
  TsmSignalState = public UInt32;
const
  BLANK_SIGNAL                   = $00000000;
  RED_SIGNAL                     = $00000001;
  YELLOW_SIGNAL                  = $00000002;
  GREEN_SIGNAL                   = $00000003;
  FREE_SIGNAL                    = $00000004;
  RTOR_SIGNAL                    = $00000005;
  PROTECTED_SIGNAL               = $00000007;
  TRANSIT_PROTECTED_SIGNAL       = $00000008;
  FLASHINRED_SIGNAL              = $00000009;
  FLASHINGYELLOW_SIGNAL          = $0000000A;
  NONTRANSIT_PERMITTED_SIGNAL    = $0000000B;
  BLOCKED_SIGNAL                 = $0000000C;
  NONTRANSIT_PROTECTED_SIGNAL    = $0000000F;

type
  TsmVP = public UInt32;
const
  VP_COORD                       = $00000000;
  VP_HEADING                     = $00000001;
  VP_3D                          = $00000002;
  VP_ALL                         = $00000003;

type
  TsmTripType = public UInt32;
const
  TT_REGULAR                     = $00000000;
  TT_ACCESS                      = $00000001;
  TT_BUSINESS                    = $00000002;
  TT_CLOSING                     = $00000003;

type
  TsmControllerType = public UInt32;
const
  CONTROLLER_UNKNOWN             = $FFFFFFF7;
  CONTROLLER_METERING            = $FFFFFFFF;
  CONTROLLER_LANEACCESS          = $00000000;
  CONTROLLER_PRETIMED            = $00000001;
  CONTROLLER_NEMA                = $00000002;
  CONTROLLER_170                 = $00000003;
  CONTROLLER_OTHER               = $00000004;

type
  TsmPhaseState = public UInt32;
const
  PHASE_IDLE                     = $00000000;
  PHASE_RED                      = $00000001;
  PHASE_YELLOW                   = $00000002;
  PHASE_GREEN                    = $00000003;

type
  TsmStageState = public UInt32;
const
  STAGE_SERVED                   = $FFFFFFFF;
  STAGE_NONE                     = $00000000;
  STAGE_RED                      = $00000001;
  STAGE_YELLOW                   = $00000002;
  STAGE_GREEN                    = $00000003;

type
  TsmSectionType = public UInt32;
const
  ZONE_TOLL                      = $00000001;
  OD_TOLL                        = $00000002;

type
  TsmFareType = public UInt32;
const
  FARE_NONE                      = $00000000;
  FARE_FIXED                     = $00000001;
  FARE_TIMED                     = $00000002;
  FARE_TRAFFIC                   = $00000003;
  FARE_USER                      = $00000004;

type
  TsmAngleType = public UInt32;
const
  AZIMUTH                        = $00000000;
  CARTESIAN                      = $00000001;
  RADIAN                         = $00000002;

type
  TsmPreload = public UInt32;
const
  PRELOAD_DONE                   = $FFFFFFFF;
  PRELOAD_OFF                    = $00000000;
  PRELOAD_ON                     = $00000001;

type
  TsmVehicleType = public UInt32;
const
  VT_ETC                         = $00000200;
  VT_HOV                         = $00000800;
  VT_TRANSIT                     = $00002000;
  VT_TRUCK                       = $00008000;
  VT_USERA                       = $00020000;
  VT_USERB                       = $00080000;
  VT_HOT                         = $01000000;
  VT_PROBE                       = $04000000;
  VT_HEAVY                       = $08000000;
  VT_ALL                         = $0D0AAA00;

type
  TsmTripState = public UInt32;
const
  TRIPSTATE_PRETRIP              = $00000000;
  TRIPSTATE_UNSERVED             = $00000001;
  TRIPSTATE_ENROUTE              = $00000002;
  TRIPSTATE_STALLED              = $00000003;
  TRIPSTATE_MISSED               = $00000004;
  TRIPSTATE_DONE                 = $00000005;
  TRIPSTATE_PRELOAD              = $00000006;
  TRIPSTATE_ABORTED              = $00000007;

type
  TsmLaneChangeState = type Int16;
const
  LCS_RIGHT                      = $0001;
  LCS_LEFT                       = $0002;
  LCS_LR                         = $0003;
  LCS_CHANGING                   = $0004;
  LCS_MANDATORY                  = $0010;

type
  STsmTransitInfo = public record
  public
    var Size: Int16;
    var TripID: Int16;
    var NumberOfPassengers: Int16;
    var MaxCapacity: Int16;
    var RouteID: Integer;
    var StopID: Integer;
    var Delay: Single;
    var Reserved: Integer;
  end;

  STsmLocation = public record
  public
    var &Type: TsmLocationType;
    var ID: Integer;
  end;

  STsmCoord3 = public record
  public
    var Longitude: Integer;  // 10^-6 degrees
    var Latitude: Integer;   // 10^-6 degrees
    var Elevation: Single;   // meters or feet.
  end;

  STsmPathInfo = public record
  public
    var Size: Int16;
    var NumberOfLink: Int16;
    var StartLinkIndex: Int16;
    var OriginLinkIndex: Int16;
    var DestinationLinkIndex: Int16;
    var NumberOfNodesWithSignalsAndSigns: Int16;
    var PathID: Integer;
    var LengthByFreeway: array[0..1] of Single;
    var TravelTime: Single;
    var Toll: Single;
    var GeneralizedCost: Single;
    var UserCost: Single;
  end;

  STsmVehicleInfo = public record
  public
    var Size: Int16;
    var LaneChangeState: TsmLaneChangeState;
    var Accel: Single;
    var Speed: Single;
    var DesiredSpeed: Single;
    var OffsetFromLaneCenter: Single;
  end;

  STsmPosition = public record
  public
    var Longitude: Integer;
    var Latitude: Integer;
    var Elevation: Single;
    var Angle: Single;
    var Angle1: Single;
    var Angle2: Single;
  end;

  STsmPositionXyz = public record
  public
    var X: Double;
    var Y: Double;
    var Z: Double;
    var Angle: Double;
    var Angle1: Double;
    var Angle2: Double;
  end;

  STsmPoint3 = public record
  public
    var X: Double;
    var Y: Double;
    var Z: Single;
  end;

  [COM, Guid('{9B3B22CA-9E51-4124-9B05-21A1FE538E32}')]
  _ISimulationEvents = public interface(IUnknown)
    [CallingConvention(CallingConvention.Stdcall)]
    method OnProjectOpened(
        const aProjectFileName: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStarting(
        aRunSeqID: Int16;
        aRunType: TsmRunType;
        aIsInPreload: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStarted: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnAdvance(
        aTime: Double;
        out aNextTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStopped(
        aState: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationEnded(
        aState: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnProjectClosed: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnTsmApplicationShutdown: HRESULT;
  end;

  [COM, Guid('{5683D24E-0FB1-480D-A153-E78C91BC8047}')]
  _ISensorEvents = public interface(IUnknown)
    [CallingConvention(CallingConvention.Stdcall)]
    method OnVehicleEnter(
        aSensorID: Integer;
        aVehicleID: Integer;
        aActivateTime: Double;
        aSpeed: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnVehicleLeave(
        aSensorID: Integer;
        aVehicleID: Integer;
        aDeactivateTime: Double;
        aSpeed: Single
        ): HRESULT;
  end;

  [COM, Guid('{5683D24E-0FB1-480D-A154-E78C91BC8047}')]
  _ISignalEvents = public interface(IUnknown)
    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalPlanStarted(
        aCookie: Integer;
        aControllClass: TsmControlClass;
        aIDs: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalPlanEnded(
        aCookie: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnHotFaresInitialized(
        aEntranceID: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnHotFaresReleased(
        aEntranceID: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalStateChanged(
        aSignalID: Integer;
        aTime: Double;
        aState: TsmSignalState
        ): HRESULT;
  end;

  [COM, Guid('{266A8735-597B-45BD-90CB-80796741BD64}')]
  _IVehicleEvents = public interface(IUnknown)
    [CallingConvention(CallingConvention.Stdcall)]
    method OnDeparted(
        aVehicleID: Integer;
        aTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnParked(
        aVehicleID: Integer;
        aTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnStalled(
        aVehicleID: Integer;
        aTime: Double;
        aStalled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnArrived(
        aVehicleID: Integer;
        aTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterLane(
        const aVehicle: ITsmVehicle;
        aLaneID: Integer;
        aLaneEntryTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterSegment(
        const aVehicle: ITsmVehicle;
        aSegmentID: Integer;
        aSegmentEntryTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterLink(
        const aVehicle: ITsmVehicle;
        aLinkID: Integer;
        aLinkEntryTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnPathChanged(
        const aVehicle: ITsmVehicle;
        aPathID: Integer;
        aPosition: Integer;
        aTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterTransitStop(
        aTime: Double;
        const aVehicle: ITsmVehicle;
        const aRoute: ITsmRoute;
        const aStop: ITsmStop;
        aMaxCapacity: Int16;
        aPassengers: Int16;
        aDelay: Single;
        aDefaultDwellTime: Single;
        out aDwellTime: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnAvlUpdate(
        const aVehicle: ITsmVehicle;
        aVehicleClassIndex: Int16;
        aOccupancy: Int16;
        aPremptionTypeIndex: Int16;
        var aCoordinate: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnCalculateLinkCost(
        aVehicleClassIndex: Int16;
        aOccupancy: Int16;
        aDriverGroupIndex: Int16;
        aVehicleType: TsmVehicleType;
        aLinkEntryTime: Double;
        const aFromLink: ITsmLink;
        const aLink: ITsmLink;
        var aValue: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnGetPropertyValue(
        const aVehicle: ITsmVehicle;
        aColumnIndex: Int16;
        out aValue: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSetPropertyValue(
        const aVehicle: ITsmVehicle;
        aColumnIndex: Int16;
        aValue: VARIANT
        ): HRESULT;
  end;

  [COM, Guid('{DF992021-08C4-45C9-B1CC-34E2F22D71EE}')]
  ITsmVehicle = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Okay(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Class_(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Group(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HOT(
        out pVal: TsmHotState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTransit(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTruck(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsETC(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsUserA(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsUserB(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsProbe(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTollFree(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsLaneless(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsMotorized(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserA(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_UserA(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserB(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_UserB(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MinGap(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VOT(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Occupants(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TransitInfo(
        out pVal: STsmTransitInfo
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Origin(
        out pVal: STsmLocation
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Destination(
        out pVal: STsmLocation
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetDestination(
        var pDes: STsmLocation;
        idPath: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitLink(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitPosition(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ExitPosition(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitRelativePosition(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ExitRelativePosition(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Connector(
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Path(
        out pVal: ITsmPath
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextLink(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextTurn(
        out pVal: TsmTurn
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastConnector(
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Fidelity(
        out pVal: TsmFidelity
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Distance(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Offset(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Offset(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DesiredSpeed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_DesiredSpeed(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Speed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Speed(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Acceleration(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Acceleration(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Info(
        out pVal: STsmVehicleInfo
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Info(
        pVal: ^STsmVehicleInfo
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MaxAcceleration(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneChanges(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneChanging(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Front(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Back(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Leader(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Follower(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LeaderInLeftLane(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LeaderInRightLane(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FollowerInLeftLane(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FollowerInRightLane(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Position(
        fOffset: Single;
        mask: TsmVP;
        out pVal: STsmPosition
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method PositionXyz(
        fOffset: Single;
        mask: TsmVP;
        out pVal: STsmPositionXyz
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Stop(
        bSlowly: VARIANT_BOOL;
        bStall: VARIANT_BOOL;
        fStopTime: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Start: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method MoveTo(
        fDis: Single;
        fSpeed: Single;
        fAcc: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method MoveToLane(
        idLane: Integer;
        fDis: Single;
        fSpeed: Single;
        fAcc: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method MoveToConnector(
        idConnector: Integer;
        fDis: Single;
        fSpeed: Single;
        fAcc: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ChangeLane(
        iLane: Int16;
        fSpeed: Single;
        fAcc: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateRouteChoice(
        out pIdLink: Integer;
        out pIdPath: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Tracking(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Tracking(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Marked(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Marked(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AccTracking(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AccTracking(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AccOverride(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AccOverride(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Stalled(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Stalled(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Stall(
        bSlowly: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Center(
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetTripInfo(
        var ppVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TripType(
        out pVal: TsmTripType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PreviousID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parked(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleType(
        out pVal: TsmVehicleType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Gap(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Headway(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_GapTo(
        idVehicle: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AutomationLevel(
        out pVal: TsmVALevel
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AutomationLevel(
        pVal: TsmVALevel
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;
  end;

  [COM, Guid('{0D99A556-F2CE-47BB-B292-D72C4EE3AE0D}')]
  ITsmObject = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_aIndex(
        out pVal: Integer
        ): HRESULT;
  end;

  [COM, Guid('{BD329B79-5C12-4477-A453-90B838EF36F2}')]
  ITsmLink = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SegmentCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segments(
        out pVal: ITsmSegments
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        iPosition: Int16;
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_BeginSegment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EndSegment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Direction(
        out pVal: TsmDirection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CardinalDirection(
        out pVal: TsmDirection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamNode(
        out pVal: ITsmNode
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamNode(
        out pVal: ITsmNode
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Opposite(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamOpposite(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamOpposite(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitSignal(
        out pVal: ITsmSignal
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Signals(
        out pVal: ITsmSignals
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SiblingLink(
        iPosition: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstDownstreamLink(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_OppositeApproach(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TurnAngle(
        iDnsLink: Int16;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TurnType(
        iDnsLink: Int16;
        out pVal: TsmTurn
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Turns(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamaIndex(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamaIndex(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsConnectedTo(
        iDnsLink: Int16;
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsUturn(
        iDnsLink: Int16;
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MovementaIndex(
        iDnsLink: Int16;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalaIndex(
        iDnsLink: Int16;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignedID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTwoWay(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsAB(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsBA(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SuperLinkID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_SuperLinkID(
        pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SuperLink(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SpillbackQueue(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FlowRate(
        iDnsLink: Int16;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateTurnMovements(
        volumes: VARIANT;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamLinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamLink(
        iUpsLink: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ApproachingLinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ApproachingLink(
        iUpsLink: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLink(
        jDnsLink: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamMovementCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamMovementCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ReverseLink(
        const Position: OleString;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLinkByTurn(
        const Turn: OleString;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ApproachLinkByTurn(
        const Turn: OleString;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetDetectorsForMovements(
        mvts: VARIANT; fHeadway: Single;
        const pOptions: ITsmAttributes;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetHistoricalTravelTime(
        dTime: Double;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetUpdatedTravelTime(
        dTime: Double;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ShortestPath(
        const pSettings: ITsmAttributes;
        var pDes: STsmLocation;
        out pTime: Single;
        out pCost: Single;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Enable(
        bEnable: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Disable(
        bDisable: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Enabled(
        out pEnabled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Enabled(
        pEnabled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Disabled(
        out pDisabled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Disabled(
        pDisabled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalTurnType(
        iTurn: Int16;
        out pVal: TsmTurn
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TurnSignalCount(
        out pVal: Int16
        ): HRESULT;
  end;

  [COM, Guid('{C9949A42-BC30-4713-B072-8596AE67DF10}')]
  ITsmCollection = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;
  end;

  [COM, Guid('{758CEC73-08EB-4907-B941-F115EF3F93AB}')]
  ITsmSegments = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmSegment
        ): HRESULT;
  end;

  [COM, Guid('{51F0EA1F-7645-470D-AA1B-B442FAE9FD8E}')]
  ITsmSegment = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Fidelity(
        out pVal: TsmFidelity
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Opposite(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Upstream(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Downstream(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Grade(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Grade(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Curvature(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Curvature(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FreeFlowSpeed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SpeedLimit(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Direction(
        out pVal: TsmDirection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Angle(
        fPosition: Single;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Width(
        fPosition: Single;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LeftCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CenterCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RightCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_OffsetCoord(
        fPosition: Single;
        fOffset: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Elevation(
        fPosition: Single;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ReversibleLaneCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lanes(
        out pVal: ITsmLanes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        iPosition: Int16;
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LeftLane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RightLane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorStations(
        out pVal: ITsmSensorStations
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignedID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTwoWay(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsAB(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsBA(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Flow(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Density(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Speed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Congestion(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstVehicle(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastVehicle(
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Vehicles(
        out pVal: ITsmVehicles
        ): HRESULT;
  end;

  [COM, Guid('{BAC1C49F-0218-48A3-9BCC-026E2F20A67B}')]
  ITsmLanes = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmLane
        ): HRESULT;
  end;

  [COM, Guid('{81AF5B60-3800-4290-B51C-BE15FB2515E1}')]
  ITsmLane = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamConnectorCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamConnectorCount(
		  out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamConnector(
        iPosition: Int16;
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamConnector(
        iPosition: Int16;
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Left(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Right(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Reverse(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Position(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Turns(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LeftCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CenterCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RightCoord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Width(
        fPosition: Single;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MinimumWidth(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ParkingSpaces(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FreeParkingSpaces(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstFreeParkingSpace(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastFreeParkingSpace(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ParkingSpaceAt(
        fDistance: Single;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsParkingSpaceFree(
        iSpace: Int16;
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetParkedVehicle(
        iSpace: Int16;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method DepartParkedVehicle(
        iSpace: Int16;
        var pDes: STsmLocation;
        idPath: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneGroup(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Reversible(
        out pVal: TsmReversible
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Side(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Auxiliary(
        out pVal: TsmAuxiliary
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Merged(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Merging(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Pivot(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Exit(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Dropped(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parking(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Passing(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Shoulder(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ETC(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HOV(
        out pVal: TsmHOV
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Transit(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Truck(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserA(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserB(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HOT(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Bicycle(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AutomationLevel(
        out pVal: TsmVALevel
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AutomationLevel(
        pVal: TsmVALevel
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Density(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Speed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneChange(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_LaneChange(
        pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Barrier(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Barrier(
        pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;
  end;

  [COM, Guid('{D3A0E4C9-5D65-404D-B7C2-0B25D48B08E3}')]
  ITsmConnector = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamLane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Direction(
        out pVal: TsmDirection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Turn(
        out pVal: TsmTurn
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DistanceToStopBar(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DistanceToYieldPoint(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Angle(
        fPosition: Single;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Coord(
        fPosition: Single;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Intersection(
        idConnector: Integer;
        out pDistance: Single;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Conflicts(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_YieldTos(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_YieldBys(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ConnectivityBias(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ConnectivityBias(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Left(
        iType: TsmConnectorType;
        out pVal: ITsmConnectors
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Right(
        iType: TsmConnectorType;
        out pVal: ITsmConnectors
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method IsLine(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ArcLength(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DistanceBeforeArc(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DistanceAfterArc(
        out pVal: Single
        ): HRESULT;
  end;

  [COM, Guid('{C4A1CECC-E566-482B-B427-A114A4FA69BD}')]
  ITsmConnectors = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmConnector
        ): HRESULT;
  end;

  [COM, Guid('{A7602159-378B-46DD-920F-189048B45AC5}')]
  ITsmSensorStations = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmSensorStation
        ): HRESULT;
  end;

  [COM, Guid('{92FFCB56-F9F4-4DC3-B0EF-64A109278820}')]
  ITsmSensorStation = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Direction(
        out pVal: TsmDirection
        ): HRESULT;
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Distance(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Detection(
        out pVal: TsmDetectionType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Operation(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypePoint(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypeVRC(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypeArea(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsLinkWide(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsOnConnector(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Sensors(
        out pVal: ITsmSensors
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Flow(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Speed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Occupancy(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Headway(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TotalCount(
        out pVal: Integer
        ): HRESULT;
  end;

  [COM, Guid('{75E00364-FD5A-4633-A6CF-AB18E5061867}')]
  ITsmSensors = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmSensor
        ): HRESULT;
  end;

  [COM, Guid('{64BACF71-2686-404F-B379-F4CA81F270B7}')]
  ITsmSensor = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Station(
        out pVal: ITsmSensorStation
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StationID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Connector(
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Direction(
        out pVal: TsmDirection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Turns(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Distance(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Coord(
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Detection(
        out pVal: TsmDetectionType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Operation(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypePoint(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypeVRC(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTypeArea(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsLinkWide(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsNotifyingEvents(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_IsNotifyingEvents(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Reset: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Flow(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Speed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Occupancy(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Headway(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TotalCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastActuationTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsActivated(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_IsActivated(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsOccupied(
        out pVal: VARIANT_BOOL
        ): HRESULT;
  end;

  [COM, Guid('{62525380-FD3B-4E39-BA2E-334CD9828194}')]
  ITsmVehicles = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetVehicle(
        vid: Integer;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Update: HRESULT;
  end;

  [COM, Guid('{F4AA34C9-0DA6-47DD-9E9F-C1BA14F30C59}')]
  ITsmNode = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Fidelity(
        out pVal: TsmFidelity
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamLinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamLink(
        iUpsLink: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamLink(
        jDnsLink: Int16;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UpstreamConnections(
        jUpsLink: Int16;
        iDnsLink: Int16;
        out pVal: UInt32
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DownstreamConnections(
        iUpsLink: Int16;
        jDnsLink: Int16;
        out pVal: UInt32
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ConnectorCount(
        iUpsLink: Int16;
        jDnsLink: Int16;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Connectors(
        iUpsLink: Int16;
        jDnsLink: Int16;
        out pVal: ITsmConnectors
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Signals(
        out pVal: ITsmSignals
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Elevation(
        const flag: OleString;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Radius(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LinkByApproach(
        approach: TsmDirection;
        out pVal: ITsmLink
        ): HRESULT;
  end;

  [COM, Guid('{F87CE8DD-D4A5-447D-A827-80255E8D70F8}')]
  ITsmSignals = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmSignal
        ): HRESULT;
  end;

  [COM, Guid('{A5345C5C-9C50-4A28-BC55-0A3001E6789D}')]
  ITsmSignal = public interface(ITsmObject)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StationID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Connector(
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Node(
        out pVal: ITsmNode
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Distance(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Coord(
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_type_(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleTypes(
        out pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_VehicleTypes(
        const pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsNotifyingEvents(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_IsNotifyingEvents(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Scripted(
        out pScripted: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Scripted(
        pScripted: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetState(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetState(
        const fldName: OleString;
        newVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_State(
        out pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_State(
        const pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartOfCurrentState(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalState(
        iDnsLink: Int16;
        out pVal: TsmSignalState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_SignalState(
        iDnsLink: Int16;
        pVal: TsmSignalState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartOfCurrentSignalState(
        iDnsLink: Int16;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TurnSignalState(
        iTurn: Int16;
        out pVal: TsmSignalState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_TurnSignalState(
        iTurn: Int16;
        pVal: TsmSignalState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartOfCurrentTurnSignalState(
        iTurn: Int16;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TurnMovementCount(
        out pVal: Int16
        ): HRESULT;
  end;

  [COM, Guid('{4D6F5D2F-4E79-4151-BCB9-8E67A0EB4DA6}')]
  ITsmAttributes = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Attribute(
        const Name: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Attribute(
        const Name: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: VARIANT;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Item(
        aIndex: VARIANT;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        iPosition: Integer;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        iPosition: Integer;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get(
        const Name: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_(
        const Name: OleString;
        newVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method &Remove(
        const Name: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveAll: HRESULT;
  end;

  [COM, Guid('{63F34616-46C8-4BD9-A54B-363ECE4339DC}')]
  ITsmPath = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_aIndex(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Links(
        iStart: Int16;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstLink(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        iPosition: Int16;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastLink(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextTurn(
        iPosition: Int16;
        out pVal: TsmTurn
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FindLink(
        iLink: Integer;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetInfo(
        iStart: Int16;
        const pSettings: ITsmAttributes;
        out pVal: STsmPathInfo
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Active(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Active(
        pVal: VARIANT_BOOL
        ): HRESULT;
  end;

  [COM, Guid('{41931BF9-CF69-40DB-A57B-BA9BA9A0322D}')]
  ITsmRoute = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_aIndex(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LinkCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Links(
        iStart: Int16;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstLink(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        iPosition: Int16;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LastLink(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FindLink(
        iLink: Integer;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleType(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ControlType(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Stops(
        out pVal: ITsmStops
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StopCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Stop(
        iPosition: Int16;
        out pVal: ITsmStop
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetStopFromID(
        id: Integer;
        out pVal: ITsmStop
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsScheduleBased(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MeanHeadway(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_MeanHeadway(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HeadwayStdDev(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_HeadwayStdDev(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCount(
        out pVal: Integer
        ): HRESULT;
  end;

  [COM, Guid('{086DC5FC-3734-438E-9D57-557C4D598324}')]
  ITsmStops = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        iPosition: Int16;
        out pVal: ITsmStop
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ItemByID(
        id: Integer;
        out pVal: ITsmStop
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ItemByPhysicalStopID(
        id: Integer;
        out pVal: ITsmStop
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        iPosition: Int16;
        out pVal: ITsmStop
        ): HRESULT;
  end;

  [COM, Guid('{342A66DE-B022-47C7-96C5-3B65039C350E}')]
  ITsmStop = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhysicalStopID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsTimePoint(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Distance(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DistanceFromNode(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Side(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ArrivingRate(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ArrivingRate(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AlightingRate(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AlightingRate(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Value(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Value(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhysicalStopValue(
        const fldName: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_PhysicalStopValue(
        const fldName: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TimeLastServed(
        out pVal: Double
        ): HRESULT;
  end;

  [COM, Guid('{758966B7-BDFD-4D3D-AA50-18DF799BB435}')]
  ITsmApplication = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Open(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OpenFile(
        const FileName: OleString;
        bReadOnly: VARIANT;
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Start(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Reset: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Close: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CloseAll: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Pause(
        bPause: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Rewind(
        const fname: OleString;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Run(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RunSingleStep: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RunTo(
        vtTime: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RunStep(
        dSecond: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StepMode(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_StepMode(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Network(
        out pVal: ITsmNetwork
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TrafficManager(
        out pVal: ITsmTrafficManager
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Router(
        out pVal: ITsmRouter
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Transit(
        out pVal: ITsmTransit
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EnableLinkCostCallback(
        const pHandle: _IVehicleEvents;
        bEnable: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Function_(
        const funcname: OleString;
        args: VARIANT;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Macro(
        const macroname: OleString;
        const dbname: OleString;
        args: VARIANT;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateUserVehicleProperty(
        const pHandle: _IVehicleEvents;
        const Name: OleString;
        const type_: OleString;
        Width: Int16;
        decimals: Int16;
        bEditable: VARIANT_BOOL;
        const aDescription: OleString;
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ReleaseUserVehicleProperties: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetFolder(
        const Name: OleString;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindFolder(
        const dir: OleString;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ProgramFolder(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ProgramDataFolder(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ProjectFolder(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_OutputBaseFolder(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_OutputFolder(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]

    method Get_TripTable(
        out pVal: OleString
        ): HRESULT;
    [CallingConvention(CallingConvention.Stdcall)]

    method Get_IsUnitMetric(
        out pVal: VARIANT_BOOL
        ): HRESULT;
    [CallingConvention(CallingConvention.Stdcall)]

    method Get_AngleType(
        out pVal: TsmAngleType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AngleType(
        pVal: TsmAngleType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RollingAverage(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_RollingAverage(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ProfileItem(
        const Name: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ProfileItem(
        const Name: OleString;
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetProfileItem(
        const Name: OleString;
        newVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartTime(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_StartTime(
        pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EndTime(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_EndTime(
        pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MaximumRuns(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_MaximumRuns(
        pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CurrentTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_State(
        out pVal: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_State(
        pVal: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RunType(
        out pVal: TsmRunType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_RunType(
        pVal: TsmRunType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RunIteration(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Preload(
        out pVal: TsmPreload
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PauseTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_PauseTime(
        pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StepSize(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_StepSize(
        pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AdvanceTime(
        idCP: Integer;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_AdvanceTime(
        idCP: Integer;
        pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ReloadIncidents(
        const fname: VARIANT
        ): HRESULT;

   [CallingConvention(CallingConvention.Stdcall)]
    method ReloadParameters(
        const fname: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EditParameters(
        const fname: OleString;
        const pOptions: ITsmAttributes;
        out pExitPage: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method StringToTime(
        const bstrTime: OleString;
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method TimeToString(
        dTime: Double;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Distance(
        var p1: STsmCoord3;
        var p2: STsmCoord3;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetStatusBarMessage(
        const msg: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ClearStatusBarMessage: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetLastErrorMessage(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetErrorDescription(
        hr: HRESULT;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetExitMessage(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetExitMessage(
        const msg: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method LogErrorMessage(
        const msg: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Crc32(
        const str: OleString;
        out pVal: UInt32
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HWND_(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MaxInstanceCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Instance(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_InstanceLabel(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateControllerList: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveControllerList: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetCycleLength(
        iClass: TsmControlClass;
        lTime: Integer;
        id: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetOffset(
        iClass: TsmControlClass;
        lTime: Integer;
        id: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetupIntersectionReport(
        const fname: OleString;
        const fld: OleString;
        nInterval: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetIntersectionReport(
        idNode: Integer;
        const tms: OleString;
        out pStream: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateIntersectionReport(
        idNode: Integer;
        const tms: OleString;
        const fname: OleString;
        bOpen: VARIANT_BOOL
        ): HRESULT;
  end;

  [COM, Guid('{D57DE796-602F-4EB9-B441-7ECB00FC42A2}')]
  ITsmNetwork = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NodeCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LinkCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SegmentCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorStationCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NodeAt(
        iNode: Integer;
        out pVal: ITsmNode
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LinkAt(
        iLink: Integer;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SegmentAt(
        iSegment: Integer;
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneAt(
        iLane: Integer;
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorAt(
        iSensor: Integer;
        out pVal: ITsmSensor
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalAt(
        iSignal: Integer;
        out pVal: ITsmSignal
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorStationAt(
        iStation: Integer;
        out pVal: ITsmSensorStation
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Node(
        idNode: Integer;
        out pVal: ITsmNode
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        idLink: Integer;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        idSegment: Integer;
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        idLane: Integer;
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Sensor(
        idSensor: Integer;
        out pVal: ITsmSensor
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Signal(
        idSignal: Integer;
        out pVal: ITsmSignal
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Connector(
        idConnector: Integer;
        out pVal: ITsmConnector
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorStation(
        idStation: Integer;
        out pVal: ITsmSensorStation
        ): HRESULT;

   [CallingConvention(CallingConvention.Stdcall)]
    method Reload(
        const type_: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SegmentInfo(
        var pCoord: STsmCoord3;
        const pOptions: ITsmAttributes;
        out pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Nodes(
        out pVal: ITsmNodes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Links(
        out pVal: ITsmLinks
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segments(
        out pVal: ITsmSegments
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lanes(
        out pVal: ITsmLanes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Sensors(
        out pVal: ITsmSensors
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Signals(
        out pVal: ITsmSignals
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SensorStations(
        out pVal: ITsmSensorStations
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsLeftSideTraffic(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetNotifyingSensorEvents(
        newVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetNotifyingSignalEvents(
        newVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCountInNetwork(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCountQueued(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCountMissed(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCountCompleted(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_VehicleCountNotDeparted(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Vehicle(
        id: Integer;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Vehicles(
        out pVal: ITsmVehicles
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddVehicle(
        var pOri: STsmLocation;
        var pDes: STsmLocation;
        const pOptions: ITsmAttributes;
        out pVal: ITsmVehicle
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveVehicle(
        idVehicle: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveTrip(
        idVehicle: Integer
        ): HRESULT;

    // Added 2019-07-01
    [CallingConvention(CallingConvention.Stdcall)]
    method TripState(
        idVehicle: Integer;
        out pVal: TsmTripState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddVehicles(
        Vehicles: VARIANT;
        const pOptions: ITsmAttributes;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveVehicles(
        idVehicles: VARIANT;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveTrips(
        idVehicles: VARIANT;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SaveCurrentState(
        const fname: OleString;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Center(
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Corner(
        iPosition: Int16; // 0-NE, 1-NW, 2-SW, 3-SE
        var pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method XyzToCoordinate(
        var pt: STsmPoint3;
        out pVal: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CoordinateToXyz(
        var Coord: STsmCoord3;
        out pVal: STsmPoint3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MaxTurnSpeed(
        iClass: Int16;
        iAngle: Int16;
        out pVal: Single
        ): HRESULT;
  end;

  [COM, Guid('{ECA7B86F-60D4-4FBC-ACB7-AE87A0FD7887}')]
  ITsmNodes = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmNode
        ): HRESULT;
  end;

  [COM, Guid('{7CFD586F-6BB3-4E5C-8CD9-4CF6C10E1570}')]
  ITsmLinks = public interface(ITsmCollection)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmLink
        ): HRESULT;
  end;

  [COM, Guid('{8276A6F2-F679-49B5-8356-E904E89D4073}')]
  ITsmTrafficManager = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Controller(
        iClass: TsmControlClass;
        id: Integer;
        out pVal: ITsmController
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Controllers(
        out pVal: ITsmControllers
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateTrafficControl(
        const fname: OleString;
        dStartTime: Double;
        bReplace: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ActivatePlan(
        iClass: TsmControlClass;
        nodeid: Integer;
        const planid: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollFreeTypes(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_TollFreeTypes(
        pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HotEntrance(
        id: Integer;
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindHotEntrance(const Name: OleString;
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HotEntrances(
        out pVal: ITsmHotEntrances
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollPlaza(
        id: Integer;
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindTollPlaza(
        const Name: OleString;
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollPlazas(
        out pVal: ITsmTollPlazas
        ): HRESULT;
  end;

  [COM, Guid('{BE421016-C4CA-42CD-AA0D-1499D10BF9C5}')]
  ITsmController = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ids(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Class_(
        out pVal: TsmControlClass
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_type_(
        out pVal: TsmControllerType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Managed(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Managed(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parameter(
        const Name: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parameters(
        out pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Signal(
        iSignal: Int16;
        out pVal: ITsmSignal
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CycleLength(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Offset(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Offset(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TimeInCycle(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsCoordinated(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsPreempted(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsRecovering(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsPhaseInService(
        const idPhase: OleString;
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Phases(
        out pVal: ITsmPhases
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhasesInService(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Phase(
        const idPhase: OleString;
        out pVal: ITsmPhase
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method StartPhase(
        const idPhase: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method StartTransition(
        const idPhase: OleString;
        YellowTime: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method EndPhase(
        const idPhase: OleString;
        KeepState: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Stages(
        out pVal: ITsmStages
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StageInService(
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FirstStage(
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Stage(
        const id: OleString;
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhaseCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetPhase(
        iPhase: Int16;
        out pVal: ITsmPhase
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StageCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetStage(
        iStage: Int16;
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LaneChange(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_LaneChange(
        pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Barrier(
        out pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Barrier(
        pVal: TsmSide
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ETC(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ETC(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_HOV(
        out pVal: TsmHOV
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_HOV(
        pVal: TsmHOV
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Transit(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Transit(
        pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Truck(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Truck(
        pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserA(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_UserA(
        pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserB(
        out pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_UserB(
        pVal: TsmAccess
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Open(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Open(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Closed(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Closed(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Refresh: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method TransitionTo(
        dCycle: Double;
        dOffset: Double;
        nPhases: Int16;
        var pIDs: OleString;
        var pSplits: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Reversible(
        id: Integer;
        out pVal: TsmReversible
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Reversible(
        id: Integer; pVal: TsmReversible
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserRateOverride(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_UserRateOverride(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_MeteringRate(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_MeteringRate(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhaseUserFieldCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhaseUserFieldName(
        iPosition: Int16;
        out pVal: OleString
        ): HRESULT;
  end;

  [COM, Guid('{488A51F1-9401-464C-B6B1-8AA4A8256421}')]
  ITsmPhases = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        const id: OleString;
        out pVal: ITsmPhase
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        iPosition: Int16;
        out pVal: ITsmPhase
        ): HRESULT;
  end;

  [COM, Guid('{F078F3F1-6476-445A-9796-D535D0F3DCDC}')]
  ITsmPhase = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_CallDetectors(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExtensionDetectors(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsCoordinated(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsPedestrianExclusive(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsInService(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsCalled(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsPedestrianCalled(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_State(
        out pVal: TsmPhaseState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Length(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Length(
        pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Green(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Green(
        pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Yellow(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Red(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartTimeInCycle(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EarliestEndTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LatestEndTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignalState(
        iSignal: Int16;
        iTurn: Int16;
        out pVal: TsmSignalState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parameter(
        const Name: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Parameters(
        out pVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PedCrosswalks(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PedLinks(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_AmberTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EndTime(
        out pVal: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TimeToGapOut(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_TimeToGapOut(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_UserFieldValue(
        iPosition: Int16;
        out pVal: OleString
        ): HRESULT;
  end;

  [COM, Guid('{9C0EE7A4-B717-4335-B2E2-B610369F7800}')]
  ITsmStages = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        const id: OleString;
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        iPosition: Int16;
        out pVal: ITsmStage
        ): HRESULT;
  end;

  [COM, Guid('{5FAC1421-56A5-4C64-BABB-B4BA2668FB80}')]
  ITsmStage = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_aIndex(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PhaseCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Phases(
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Phase(
        const idPhase: OleString;
        out pVal: ITsmPhase
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextStageCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_NextStage(
        iRoute: Int16;
        out pVal: ITsmStage
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_LatestStartTime(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ForceOffTime(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TimeRemainsBeforeForceOff(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_State(
        out pVal: TsmStageState
        ): HRESULT;
  end;

  [COM, Guid('{41DFF515-50A5-4BF0-A160-255C440844B1}')]
  ITsmControllers = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        iClass: TsmControlClass;
        id: Integer;
        out pVal: ITsmController
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateItems: HRESULT;
  end;

  [COM, Guid('{5FAC1421-56A5-4C64-BABB-B4BA2668FBA1}')]
  ITsmHotEntrance = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SectionCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Section(
        aIndex: Integer;
        out pVal: ITsmHotSection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Sections(
        out pVal: ITsmHotSections
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindSection(
        const Name: OleString;
        out pVal: ITsmHotSection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindSectionsBefore(
        const Section: OleString;
        out pVal: ITsmHotSections
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SectionType(
        out pVal: TsmSectionType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_FareType(
        out pVal: TsmFareType
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_SignCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Sign(
        iPosition: Integer;
        out pVal: ITsmSignal
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EntryLinkCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EntryLink(
        iPosition: Integer;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Fares(
        const Section: OleString;
        out pVals: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Fares(
        const Section: OleString;
        pVals: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Fare(
        const Section: OleString;
        iHov: TsmHOV;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Fare(
        const Section: OleString;
        iHov: TsmHOV;
        pVal: Single
        ): HRESULT;
  end;

  [COM, Guid('{5FAC1421-56A5-4C64-BABB-B4BA2668FBA3}')]
  ITsmHotSection = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Entrance(
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitLinkCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitLink(
        iPosition: Integer;
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_DetectorCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Detector(
        iPosition: Integer;
        out pVal: ITsmSensor
        ): HRESULT;
  end;

  [COM, Guid('{9C0EE7A4-B717-4335-B2E2-B610369F78A4}')]
  ITsmHotSections = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmHotSection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmHotSection
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindSection(
        const Section: OleString;
        out pVal: ITsmHotSection
        ): HRESULT;
  end;

  [COM, Guid('{9C0EE7A4-B717-4335-B2E2-B610369F78A1}')]
  ITsmHotEntrances = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Entrance(
        id: Integer;
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmHotEntrance
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindEntrance(
        const Name: OleString;
        out pVal: ITsmHotEntrance
        ): HRESULT;
  end;

  [COM, Guid('{AA1AAFEA-E59E-4A16-98DE-A17A5798BD8C}')]
  ITsmTollPlaza = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Name(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Segment(
        out pVal: ITsmSegment
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Link(
        out pVal: ITsmLink
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EtcSpeed(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_EtcSpeed(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollClassCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollClassName(
        iClass: Int16;
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollBoothCount(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollBooth(
        iPosition: Int16;
        out pVal: ITsmTollBooth
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollBooths(
        out pVal: ITsmTollBooths
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Toll(
        iPosition: Integer;
        out pVal: ITsmToll
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Tolls(
        out pVal: ITsmTolls
        ): HRESULT;
  end;

 [COM, Guid('{E1295D31-13CE-4323-8A8F-28C3BEE9873D}')]
  ITsmTollBooth = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_id(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollPlaza(
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Lane(
        out pVal: ITsmLane
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_type_(
        out pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_type_(
        const pVal: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ServiceTime(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_ServiceTime(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsOpen(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_IsOpen(
        pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_IsBypass(
        out pVal: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_IsBypass(
        pVal: VARIANT_BOOL
        ): HRESULT;
  end;

  [COM, Guid('{E7604F19-753A-4279-ABB6-607871CE5968}')]
  ITsmTollBooths = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmTollBooth
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmTollBooth
        ): HRESULT;
  end;

  [COM, Guid('{1C75CA53-88EE-4BC0-B483-8F3654086875}')]
  ITsmToll = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EntryID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EntryPlaza(
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitID(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_ExitPlaza(
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_StartTime(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollClass(
        out pVal: Int16
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Toll(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_Toll(
        pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_EtcDiscount(
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Set_EtcDiscount(
        pVal: Single
        ): HRESULT;
  end;

  [COM, Guid('{D8480532-4B3C-4AF9-BAE3-2B2EAD6DF137}')]
  ITsmTolls = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmToll
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmToll
        ): HRESULT;
  end;

  [COM, Guid('{472AEC28-7441-4307-97A8-E6FD02355188}')]
  ITsmTollPlazas = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get__NewEnum(
        out pVal: IUnknown
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Item(
        aIndex: Integer;
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TollPlaza(
        id: Integer;
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Count(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetAt(
        aIndex: Integer;
        out pVal: ITsmTollPlaza
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method FindTollPlaza(
        const Name: OleString;
        out pVal: ITsmTollPlaza
        ): HRESULT;
  end;

  [COM, Guid('{2711725D-AF41-4B3B-A23C-C00501CB24E2}')]
  ITsmRouter = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Path(
        idx: Integer;
        out pVal: ITsmPath
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_PathCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetPathFromID(
        id: Integer;
        out pVal: ITsmPath
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddPathByLinkIndices(
        Links: VARIANT;
        out pStart: Int16;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddPathByLinkIDs(
        Links: VARIANT;
        out pStart: Int16;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SavePathTable(
        const fname: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateTravelTimes(
        const fname: OleString;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetHistoricalLinkTravelTime(
        dTime: Double;
        iLink: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetUpdatedLinkTravelTime(
        dTime: Double;
        iLink: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method ShortestPath(
        const pSettings: ITsmAttributes;
        var pOri: STsmLocation;
        var pDes: STsmLocation;
        out pTime: Single;
        out pCost: Single;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method UpdateRouteChoicesInGroup(
        iGroup: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateAssignmentTable(
        const bstrAssignTable: OleString;
        const bstrTripTable: OleString;
        const pOpts: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateDemandTables(
        const bstrLnkTable: OleString;
        const bstrMvtTable: OleString;
        const bstrTripTable: OleString;
        const pOpts: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetFlowsPassingLink(
        const bstrOdvTable: OleString;
        idLink: Integer;
        const bstrTripTable:
        OleString;
        const pOpts: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TripCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetNextTripID(
        var iPosition: Integer;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetTripInfo(
        id: Integer;
        const fname: OleString;
        out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateTravelTimeTable(
        const fname: OleString;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CreateMovementTable(
        const fname: OleString;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OpenTravelTimeTable(
        const fname: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetTravelTimeTableSettings(
        out ppVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetTravelTime(
        idSegment: Integer;
        iPeriod: Int16;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetTravelTime(
        idSegment: Integer;
        iPeriod: Int16;
        newVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveTravelTimes(
        idSegment: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CloseTravelTimeTable: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method OpenMovementTable(
        const fname: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetMovementTableSettings(
        out ppVal: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetMovementDelay(
        idFromLink: Integer;
        idViaNode: Integer;
        idToLink: Integer;
        iPeriod: Int16;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method SetMovementDelay(
        idFromLink: Integer;
        idViaNode: Integer;
        idToLink: Integer;
        iPeriod: Int16;
        newVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method AddMovements(
        idViaNode: Integer;
        const pOptions: ITsmAttributes
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveMovements(
        idViaNode: Integer;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method RemoveMovement(
        idFromLink: Integer;
        idViaNode: Integer;
        idToLink: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method CloseMovementTable: HRESULT;
  end;

  [COM, Guid('{D490F99E-1B3C-4E90-90B7-EE5C9A423DA5}')]
  ITsmTransit = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Route(
        idx: Integer;
        out pVal: ITsmRoute
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_RouteCount(
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method GetRouteFromID(
        id: Integer;
        out pVal: ITsmRoute
        ): HRESULT;
  end;

  [COM, Guid('{37B54C69-1721-44E5-BF7A-D10D42551F5E}')]
  ITsmService = public interface(IDispatch)
    [CallingConvention(CallingConvention.Stdcall)]
    method _HasClientsForSimulationEvent: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _HasClientsForSensorEvent: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _HasClientsForSignalEvent: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _HasClientsForVehicleEvent: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _ReloadNetwork(
        const type_: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _ResetAdvanceTime(
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _OpenProject(
        const fname: OleString
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _StartSimulation(
        iRun: Int16;
        iRunType: TsmRunType;
        bPreload: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _SimulationStarted: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _Advance(
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _SimulationStopped(
        iState: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _EndSimulation(
        iState: TsmState
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _CloseProject: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _ExitApplication: HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Application(
        out pVal: ITsmApplication
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Network(
        out pVal: ITsmNetwork
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_TrafficManager(
        out pVal: ITsmTrafficManager
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Router(
        out pVal: ITsmRouter
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method Get_Transit(
        out pVal: ITsmTransit
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _ArriveSensor(
        sid: Integer;
        vid: Integer;
        dTime: Double;
        fSpeed: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _LeaveSensor(
        sid: Integer;
        vid: Integer;
        dTime: Double;
        fSpeed: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _StartPlan(
        fname: ^AnsiChar;
        clsname: ^AnsiChar;
        cc: TsmControlClass;
        ids: VARIANT;
        out pVal: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _EndPlan(
        id: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _StartFares(
        idEntrance: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _EndFares(
        idEntrance: Integer
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _NewSignalState(
        idSignal: Integer;
        dTime: Double;
        ulState: UInt32
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _Departure(
        idVehicle: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _Parked(
        idVehicle: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _Stalled(
        idVehicle: Integer;
        dTime: Double;
        bStallled: VARIANT_BOOL
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _Arrival(
        idVehicle: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _NewLane(
        idVehicle: Integer;
        idLane: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _NewSegment(
        idVehicle: Integer;
        idSegment: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _NewLink(
        idVehicle: Integer;
        idLink: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _NewPath(
        idVehicle: Integer;
        idPath: Integer;
        iPosition: Integer;
        dTime: Double
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _TransitStop(
        dTime: Double;
        idVehicle: Integer;
        idRoute: Integer;
        idStop: Integer;
        nMaxCapacity: Int16;
        nPassengers: Int16;
        fSchedDev: Single;
        fDwellTime: Single;
        out pDwellTime: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _AVL(
        idVehicle: Integer;
        iClass: Int16;
        nOccupants: Int16;
        iType: Int16;
        var pLocation: STsmCoord3
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _LinkCost(
        iClass: Int16;
        nOccupancy: Int16;
        iGroup: Int16;
        ulType: UInt32;
        dTime: Double;
        idxFromLink: Integer;
        idxLink: Integer;
        out pVal: Single
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _GetProperty(
      idVehicle: Integer;
      iCol: Int16;
      out pVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _SetProperty(
      idVehicle: Integer;
      iCol: Int16;
      newVal: VARIANT
        ): HRESULT;

    [CallingConvention(CallingConvention.Stdcall)]
    method _OnNewTraffficControl: HRESULT;
  end;

  CoTsmApplication = public class
  public
    class method Create: ITsmApplication;
    begin
      result := CreateComObject(CLASS_TsmApplication) as ITsmApplication;
    end;
  end;

  CoTsmAttributes = public class
  public
    class method Create: ITsmAttributes;
    begin
      result := CreateComObject(CLASS_TsmAttributes) as ITsmAttributes;
    end;
  end;

end.
