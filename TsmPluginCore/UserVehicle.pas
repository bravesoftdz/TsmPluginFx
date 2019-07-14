{/*! 
     Provides interface and base class for user vehicle factory.
     
     \modified    2019-07-09 13:45pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  rtl;

type
  VehicleMonitorOption = public flags (   
      None = $00000000,
      Update = $00000001,
      Position = $00000002,
      CarFollowingSubject = $00000010,
      CarFollowingLeader = $00000020,
      CarFollowingFollower = $00000040,
      CarFollowingAll = $00000070,
      All = $0000000F
  ) of UInt32;

  TripType = public enum (
      Regular = $00,
      Access = $01,
      Business = $02,
      Closing = $03
  ) of Byte;

  SignalState = public enum (
      Blank = $00,
      Red = $01,
      Yellow = $02,
      Green = $03,
      Free = $04,
      RTOR = $05,
      ProtectedSignal = $07,
      TransitProtected = $08,
      FlashingRed = $09,
      FlashingYellow = $0A,
      NonTransitPermitted = $0B,
      Blocked = $0C,
      NonTransitProtected = $0F
  ) of Byte;

  AutomationLevel = public enum (
      L0_None = $00,
      L1A_AssistedAccelDecel = $1A,
      L1A_AssistedSteering = $1B,
      L2_Partial = $20,
      L3_Conditional = $30,
      L4_High = $40,
      L5_Full = $50
  ) of Byte;

  VehicleProperty = public record
  public
    VehicleClass: Int16;  // 1-based index to vehicle class
    Occupancts: Int16;
    Length: Single;
    Width: Single;
    PreviousTripID: Int32;
    Trip: TripType;
    Automation: AutomationLevel;
    Parked: Boolean;
  end;

  VehicleBasicState = public record
  public
    SegmentID: Int32;
    Grade: Single;
    Speed: Single;
    Accel: Single;
  end;

  TransitStopInfo = public record
  public
    RouteID: Int32;
    StopID: Int32;
    MaxCapacity: Int16;
    Passengers: Int16;
    Delay: Single;
  end;

  VehiclePosition = public record
  public
    X: Double;
    Y: Double;
    Z: Double;
    XY_Angle: Double;
    Z_Angle: Double;
  end;

  CarFollowingData = public record
  public
    VehicleID: Int32;
    Speed: Single;
    MaxSpeed: Single;
    DesiredSpeed: Single;
    CurAccel: Single;
    MaxAccel: Single;
    MaxDecel: Single;
    NormalDecel: Single;
    DistanceToStop: Single;
    StoppedGap: Single;        
    DistanceFromMLC:  Single;
    LaneChanges: SByte;
    Signal: SignalState;
    Grade: Single;
    GapDistance: Single;
    Leader: ^CarFollowingData;
    Follower: ^CarFollowingData;
  end;

  [CallingConvention(CallingConvention.FastCall)]
  DepartureMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double);

  [CallingConvention(CallingConvention.FastCall)]
  ParkedMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double);

  [CallingConvention(CallingConvention.FastCall)]
  StalledMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double; 
    aStalled: Boolean);

  [CallingConvention(CallingConvention.FastCall)]
  ArrivalMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double);

  [CallingConvention(CallingConvention.FastCall)]
  UpdateMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double; 
    aState: ^VehicleBasicState);

  [CallingConvention(CallingConvention.FastCall)]
  CarFollowingMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double;
    aData: ^CarFollowingData; 
    aTsmProposedAccelRate: Single): Single;

  [CallingConvention(CallingConvention.FastCall)]
  TransitStopMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double; 
    aTransitStopInfo: ^TransitStopInfo; 
    aDwellTime: Single): Single;

  [CallingConvention(CallingConvention.FastCall)]
  PositionMethodType = public method(
    aSelf: ^UserVehicle; 
    aTime: Double; 
    aPosition: ^VehiclePosition);

  [CallingConvention(CallingConvention.FastCall)]
  AttachVehicleFailMethodType = public method(
    aSelf: ^UserVehicle; 
    aMessage: OleString): Boolean;

  {/*! Mocks TransModeler C++ IUserVehicle interface's virtual method table. */}
  UserVehicleMethodTable = public record
  public
    DepartureMethod: DepartureMethodType;
    ParkedMethod: ParkedMethodType;
    StalledMethod: StalledMethodType;
    ArrivalMethod: ArrivalMethodType;
    UpdateMethod: UpdateMethodType;
    CarFollowingMethod: CarFollowingMethodType;
    TranitStopMethod: TransitStopMethodType;
    PositionMethod: PositionMethodType;
    AttachVehicleFailMethod: AttachVehicleFailMethodType;
  end;

  {/*! Provides a mock up of TransModeler C++ IUserVehicle interface. */}
  UserVehicle = public record
  public
    MT: ^UserVehicleMethodTable; // "Faked" C++ VMT
    Data: Object;
  end;

  UserVehicleFactory = public abstract class
  private
    fBuffer: List<^UserVehicle>;
    fLock: Integer := 0;   

    {/*! Frees a user vehicle and related resource. */}
    method DeleteUserVehicle(aUserVehicle: ^UserVehicle);
    begin   
      aUserVehicle^.Data := nil;
      free(^Void(aUserVehicle));
    end;
  protected
    method GetUserVehicleData(aID: LongInt; aProperty: ^VehicleProperty; aFlags: ^VehicleMonitorOption): Object; virtual; abstract;    
    method GetUserVehicleMethodTable: ^UserVehicleMethodTable; virtual; abstract;
  public 
    constructor;
    begin
      fBuffer := new List<^UserVehicle>(10000);
    end;

    finalizer;
    begin
      Reset;
    end;

    method CreateUserVehicle(aID: LongInt; aProperty: ^VehicleProperty; aFlags: ^VehicleMonitorOption): ^UserVehicle;
    begin
      // Create and reset the User Vehicle memory.
      result := ^UserVehicle(malloc(sizeOf(UserVehicle)));
      memset(^Byte(result), 0, sizeOf(UserVehicle));
      
      // Assigne the members.
      result^.MT := GetUserVehicleMethodTable;
      result^.Data := GetUserVehicleData(aID, aProperty, aFlags);
      
      Utilities.SpinLockEnter(var fLock);
      fBuffer.Add(result);
      Utilities.SpinLockExit(var fLock);      
    end;

    method Reset;
    begin
      for each userVehicle in fBuffer do begin
        DeleteUserVehicle(userVehicle);
      end;

      fBuffer.Clear;
    end;

    method UserVehicleDataSet<T>: ImmutableList<T>;
    begin
      var lList := new List<T>;
      for each userVehicle in fBuffer do begin
        lList.Add(userVehicle as T);
      end;

      exit lList.ToImmutableList;
    end;
  end;
end.