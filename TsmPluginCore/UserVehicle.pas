namespace Tsm.Plugin.Core;

uses
  rtl;

type
  VehicleMonitorOption = public flags (   
      None                 = $00000000,
      Update               = $00000001,
      Position             = $00000002,
      CarFollowingSubject  = $00000010,
      CarFollowingLeader   = $00000020,
      CarFollowingFollower = $00000040,
      CarFollowingAll      = $00000070,
      All                  = $0000000F
  ) of UInt32;

  VehicleMonitorTripType = public enum (
      Regular              = $00,
      Access               = $01,
      Business             = $02,
      Closing              = $03
  ) of Byte;

  VehicleMonitorSignalState = public enum (
      Blank                = $00,
      Red                  = $01,
      Yellow               = $02,
      Green                = $03,
      Free                 = $04,
      RTOR                 = $05,
      ProtectedSignal      = $07,
      TransitProtected     = $08,
      FlashingRed          = $09,
      FlashingYellow       = $0A,
      NonTransitPermitted  = $0B,
      Blocked              = $0C,
      NonTransitProtected  = $0F
  ) of Byte;

  VehicleMonitorVaLevel = public enum (
      L0_NoAutomation              = $00,
      L1A_DriverAssistedAccelDecel = $1A,
      L1A_DriverAssistedSteering   = $1B,
      L2_PartialAutomation         = $20,
      L3_ConditionalAutomation     = $30,
      L4_HighAutomation            = $40,
      L5_FullAutomation            = $50
  ) of Byte;

  VehicleProperty = public record
  public
    VehicleClass: Int16;         // 1-based index to vehicle class
    Occupancts: Int16;
    Length: Single;
    Width: Single;
    PreviousTripID: Int32;
    TripType: VehicleMonitorTripType;       // Byte
    AutomationLevel: VehicleMonitorVaLevel; // Byte
    Parked: Boolean;
  end;

  VehicleBasicState = public record
  public
    SegmentID: Int32;
    Grade: Single;
    Speed: Single;
    Acceleration: Single;
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
    DistanceToStop: Single;    // Distance to the stop position in meters
    StoppedGap: Single;        // Minimum gap distance at stopped position
    DistanceFromMLC:  Single;  // Distance from mandatory lane change.
    LaneChanges: SByte;        // Number of lane changes needed in order to to stay on path.
    SignalState: VehicleMonitorSignalState;
    Grade: Single;
    GapDistance: Single;
    Leader: ^CarFollowingData;
    Follower: ^CarFollowingData;
  end;

  [CallingConvention(CallingConvention.FastCall)]
  DepartureMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double
  );

  [CallingConvention(CallingConvention.FastCall)]
  ParkedMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double
  );

  [CallingConvention(CallingConvention.FastCall)]
  StalledMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double; 
    aStalled: Boolean
   );

  [CallingConvention(CallingConvention.FastCall)]
  ArrivalMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double
  );

  [CallingConvention(CallingConvention.FastCall)]
  UpdateMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double; 
    const var aState: VehicleBasicState
  );

  [CallingConvention(CallingConvention.FastCall)]
  CarFollowingMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double;
    const var aData: CarFollowingData; 
    aTsmProposedAccelRate: Single
  ): Single;

  [CallingConvention(CallingConvention.FastCall)]
  TransitStopMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double;
    const var aInfo: TransitStopInfo; 
    aDwellTime: Single
  ): Single;

  [CallingConvention(CallingConvention.FastCall)]
  PositionMethodType = public method(
    aSelf: PUserVehicle; 
    aTime: Double; 
    const var aPosition: VehiclePosition
  );

  [CallingConvention(CallingConvention.FastCall)]
  AttachVehicleFailMethodType = public method(
    aSelf: PUserVehicle; 
    aMessage: OleString
  ): Boolean;

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
  PUserVehicleMethodTable = ^UserVehicleMethodTable;

  UserVehicle = public record
  public
    MT: PUserVehicleMethodTable;
    Data: Object;
  end;
  PUserVehicle = ^UserVehicle;

  IUserVehicleFactory = public interface
    method CreateUserVehicle(aID: LongInt; const var aProperty: VehicleProperty; aFlags: ^VehicleMonitorOption): PUserVehicle;
  end;

  UserVehicleCreatedEventHandler
    = public block(aID: LongInt; aFlags: ^VehicleMonitorOption; aVehicle: PUserVehicle);

  UserVehicleFactory = public abstract class(IUserVehicleFactory)
  private
    method OnUserVehicleCreated(aID: LongInt; aFlags: ^VehicleMonitorOption; aVehicle: PUserVehicle);
    begin
      if assigned(UserVehicleCreated) then 
        UserVehicleCreated(aID, aFlags, aVehicle);
    end;

    method CreateUserVehicle(aID: LongInt; const var aProperty: VehicleProperty; aFlags: ^VehicleMonitorOption): PUserVehicle;
    begin
      // Create and reset the User Vehicle memory.
      result := PUserVehicle(malloc(sizeOf(UserVehicle)));
      memset(^Byte(result), 0, sizeOf(UserVehicle));
      // Assigne the members.
      result^.MT := GetUserVehicleMethodTable;
      result^.Data := GetUserVehicleData(aID, aProperty, aFlags);
      // Fire the event.
      OnUserVehicleCreated(aID, aFlags, result);
    end;
  protected
    method GetUserVehicleData(aID: LongInt; const var aProperty: VehicleProperty; aFlags: ^VehicleMonitorOption): Object; virtual; abstract;
    method GetUserVehicleMethodTable: PUserVehicleMethodTable; virtual; abstract;
  public 
    {/*! 
         \brief
            Frees a user vehicle and relases memory.
      */}
    class method FreeUserVehicle(aUserVehicle: PUserVehicle);
    begin
      aUserVehicle^.Data := nil;
      free(^Void(aUserVehicle));
    end; 

    {/*! 
         \brief 
            Occurs when a new user vehicle is created. The event handler should be defined by a plugin
            owner, while giving the plugin an opportunity to intercept data, or arrange relevant
            actions. For example, save the pointer of the newly created vehicle to an internal list
            for house-keeping purpose at the plugin level.        
      */}
    event UserVehicleCreated: UserVehicleCreatedEventHandler;
  end;

end.