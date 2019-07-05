{/*!
     \brief
        Defines various simulation events and the signatures of event handlers in
        terms of the following groups:
           - Simulation Events
           - Sensor Events
           - Vehicle Events
           - Signal Events

        Each group of events is encapsulated in respective event sink class:
           - TsmSimulationEventSink (implements ITsmSimulationEventSink interface)
           - TsmSensorEventSink (implements ITsmSensorEventSink interface)
           - TsmVehicleEventSink (implements ITsmVehicleEventSink interface)
           - TsmSignalEventSink (implements ITsmSignalEventSink interface)

        And ultimately, a TsmEventSinkManager is provided which implements ITsmEventSinkManager
        interface to facilitate managing multiple event sinks at a single location.

     \modified    2019-07-02 10:27am
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  rtl;

type
//---------------------------------------------
// Simulation Events
//---------------------------------------------

{/*!
     \brief  Occurs when a simulation project is opened.
     \param  aProjectFileName  Full path of the .smp project.
  */}
  ProjectOpenedEventHandler
    = public block (
        const aProjectFileName: OleString
    );

{/*!
     \brief  Occurs when a simulation run is being started.
     \param  aRunSeqID Current iteration ID.
     \param  aRunType  Tpe of the run.
     \param  Whether in a preload or actual simulation stage.
  */}
  SimulationStartingEventHandler
    = public block (
        aRunSeqID: Int16;
        aRunType: TsmRunType;
        aIsInPreload: VARIANT_BOOL
    );

{/*!
     \brief
        Occurs when a simulation run has all internal modules initialized,
        and simulation clock is about to start ticking.
  */}
  SimulationStartedEventHandler
    = public block;

{/*!
     \brief  Occurs when simulation clock time is being advanced.

     \param  aTime     Current simulation time in seconds past midnight.
     \param  aNextTime Next scheduled call back time for advancing event.
  */}
  SimulationAdvanceEventHandler
    = public block (
        aTime: Double;
        out aNextTime: Double
    );

{/*!
     \brief
        Occurs when a simulation run is completed, yet before all internal modules begin to
        post-process the simulation outputs.

     \param  aState
        Simulation state indicating whether a simulation finishes successfully,
        canceled by the user, or aborted due to runtime error.
  */}
  SimulationStoppedEventHandler
    = public block (
        aState: TsmState
    );


{/*!
     \brief
        Occurs when a simulation run has finished with all post
        processing of the simulation output done.

     \param  aState  Simulation state.
  */}
  SimulationEndedEvent
    = public block (
        aState: TsmState
    );

{/*!
     \brief
        Occurs when a simulation project is being closed. This is where project-specific
        cleaning up can be performed.
  */}
  ProjectClosedEventHandler
    = public block;

{/*!
     \brief  Occurs when TransModeler is shutting down.
  */}
  TsmApplicationShutdownEventHandler
    = public block;


//---------------------------------------------
// Sensor Events
//---------------------------------------------

{/*!
     \brief  Occurs when a vehicle activates the sensor.

     \param  aSensorID     Sensor ID.
     \param  aVehicleID    Vehicle ID.
     \param  aActivateTime The time when vehicle front bumper crossing the upstream edge of the sensor.
     \param  aSpeed        Vehicle speed.
 */}
  VehicleEnterEventHandler
    = public block (
        aSensorID: Integer;
        aVehicleID: Integer;
        aActivateTime: Double;
        aSpeed: Single
    );

{/*!
     \brief  Occurs when a vehicle deactivates the sensor.
     \param  aSensorID     Sensor ID.
     \param  aVehicleID    Vehicle ID.
     \param  aActivateTime The time when vehicle rear bumper crossing the downstream edge of the sensor.
     \param  aSpeed        Vehicle speed.
 */}
  VehicleLeaveEventHandler
    = public block (
        aSensorID: Integer;
        aVehicleID: Integer;
        aDeactivateTime: Double;
        aSpeed: Single
    );

//---------------------------------------------
// Signal Events
//---------------------------------------------

{/*!
     \brief  Occurs when a new signal plan is started.

     \param  aCookie
         Unique ID identifying the signal control plan.
     \param  aControllClass
         Class of controller type, such as nodes for controlled intersections, signals
         for traffic management devices, or lanes for lane access control.
     \param  aIDs
         A list of IDs of controlled features such as nodes, signals, or lanes.
  */}
  SignalPlanStartedEventHandler
    = public block (
        aCookie: Integer;
        aControllClass: TsmControlClass;
        aIDs: VARIANT
    );

{/*!
     \brief  Occurs when a signal plan is ended.
     \param  aCookie Cookie ID of the signal plan.
  */}
  SignalPlanEndedEventHandler
    = public block (
        aCookie: Integer
    );

{/*!
     \brief  Occurs when HOT faires are set to initial values for the given entrance.
     \param  aEntranceID Entrance ID.
  */}
  HotFaresInitializedEventHandler
    = public block (
        aEntranceID: Integer
    );

{/*!
     \brief  Occurs when HOT faires are released for the given entrance.
     \param  aEntranceID Entrance ID.
  */}
  HotFaresReleasedEvent
    = public block (
        aEntranceID: Integer
    );

{/*!
     \brief  Occurs when signal state is changed.
     \remark ITsmSignal::IsNotifyingEvents must have been set to true in order the for the event to be fired.
  */}
  SignalStateChangedEventHandler
    = public block (
        aSignalID: Integer;
        aTime: Double;
        aState: TsmSignalState
    );


//---------------------------------------------
// Vehicle Events
//---------------------------------------------

{/*!
     \brief  Occurs when a vehicle departs its origin.
  */}
  DepartedEventHandler
    = public block (
        aVehicleID: Integer;
        aTime: Double
    );

{/*!
     \brief  Occurs when a vehicle parks into parking space at its destination.
     \remard This event occurs before the Arrival event is fired.
  */}
  ParkedEventHandler
    = public block (
        aVehicleID: Integer;
        aTime: Double
    );

{/*!
     \brief  Occurs when a vehicle is stalled or released.
     \param  aTime     Time of the event.
     \param  aStalled  Whether the vehicle is stalled (true), or released(false).
  */}
  StalledEventHandler
    = public block (
        aVehicleID: Integer;
        aTime: Double;
        aStalled: VARIANT_BOOL
    );

{/*!
     \brief  Occurs when a vehicle arrives at its destination.
     \param  aVehicleID  ID of the vehicle.
     \param  aTime       The time when the vehicle arrives at its destination.
  */}
  ArrivedEventHandler
    = public block (
        aVehicleID: Integer;
        aTime: Double
    );

{/*!
     \brief  Occurs when a vehicle enters a new lane.
     \remark ITsmVehicle::Tracking must have been set to true in order for the event to be fired.
  */}
  EnterLaneEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aLaneID: Integer;
        aLaneEntryTime: Double
    );

{/*!
     \brief  Occurs when a vehicle enters a new segment.
     \remark ITsmVehicle::Tracking must have been set to true in order for the event to be fired.
  */}
  EnterSegmentEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aSegmentID: Integer;
        aSegmentEntryTime: Double
    );

{/*!
     \brief  Occurs when a vehicle enters a new link.
     \remark ITsmVehicle::Tracking must have been set to true in order for the event to be fired.
  */}
  EnterLinkEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aLinkID: Integer;
        aLinkEntryTime: Double
    );

{/*!
     \brief  Occurs when a vehicle changes its path en-route.

     \param  aVehicle
         The subject vehicle changing path.
     \param  aPathID
         ID of the new path. If It has a positive value, then it represents path ID
         of a normal vehicle. If it has a negative value, then it represents route ID of a transit vehicle.
         If it is 0, then the vehicle will end its trip with the next link.
     \param  aPosition
         A 0-based index to the links along the referenced path or route. If only a single link is involved,
         no path is explicitly defined and aPathID will be 0. In such case, aPosition will be a signed link ID,
         where a positive value indicates AB direction, while negative value BA direction.
     \param  aTime
         The time when the vehicle changes to the new path.

     \remark ITsmVehicle::Tracking must have been set to true in order for the event to be fired.
  */}
  PathChangedEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aPathID: Integer;
        aPosition: Integer;
        aTime: Double
    );

{/*!
     \brief  Occurs when a transit vehicle enters route stop.

     \param  aTime          Current lock time.
     \param  aVehicle       A ITsmVehicle reference.
     \param  aRoute         A ITsmRoute reference.
     \param  aStop          A ITsmStop reference.
     \param  aMaxCapacity   Maximum capacity of the stop.
     \param  aPassengers    Number of passengers on board.
     \param  aDelay         Deviation from the scedule at last stop served in seconds.
     \param  aSwellTime     A user computed dwell time for TransModeler to implement.
  */}
  EnterTransitStopEventHandler
    = public block (
        aTime: Double;
        const aVehicle: ITsmVehicle;
        const aRoute: ITsmRoute;
        const aStop: ITsmStop;
        aMaxCapacity: Int16;
        aPassengers: Int16;
        aDelay: Single;
        aDefaultDwellTime: Single;
        out aDwellTime: Single
    );

{/*!
     \brief  Occurs periodically to provide Automated Vehicle Location (AVL) update.

     \param  aPremptionTypeIndex  A 1-based index or 0 if no preemption.
     \remark ITsmVehicle::Tracking must have been set to true in order for the event to be fired.
  */}
  AvlUpdateEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aVehicleClassIndex: Int16;
        aOccupancy: Int16;
        aPremptionTypeIndex: Int16;
        var aCoordinate: STsmCoord3
    );

{/*!
     \brief
        This event provides an alternative cost of a link when computing the
        shortest path or evaluating the cost for a predefined path. The value
        returned by this function is added to the current cost of the link,
        which is either travel time or generalized cost, depending on the project
        setting for vehicle routing.

     \remark
        ITsmApplication::EnableLinkCostCallback must have been set to true
        in order for the event to be fired.
  */}
  CalculateLinkCostEventHandler
    = public block (
        aVehicleClassIndex: Int16;
        aOccupancy: Int16;
        aDriverGroupIndex: Int16;
        aVehicleType: TsmVehicleType;
        aLinkEntryTime: Double;
        const aFromLink: ITsmLink;
        const aLink: ITsmLink;
        var aValue: Single
    );

{/*!
     \brief  Occurs when the value of the user defined field is retrieved.

     \remark
         ITsmApplication::CreateUserVehicleProperty must have been called successfully
         to have the field registered in order for the event to be fired.
  */}
  GetPropertyValueEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aColumnIndex: Int16;
        out aValue: VARIANT
    );

{/*!
     \brief  Occurs when the value of the user-defined field is edited.
     \remark The field must have been registered as editable in order for the event to be fired.
  */}
  SetPropertyValueEventHandler
    = public block (
        const aVehicle: ITsmVehicle;
        aColumnIndex: Int16;
        aValue: VARIANT
    );

  [COM, Guid('{80B67AD2-79A3-4FE7-833C-AF83947B6AF8}')]
  ITsmEventSink = public interface(IUnknown)
    method ConnectEvents;
    method DisconnectEvents;
    property ConnectionID: Int32 read;
    property IsConnected: Boolean read;
    property EventSinkType: TsmEventSinkType read;
  end;

  [COM, Guid('{6F29FAA7-4AD7-425D-A1D0-DCEB6232F029}')]
  ITsmSimulationEventSink = public interface(ITsmEventSink)
    event ProjectOpened: ProjectOpenedEventHandler;
    event ProjectClosed: ProjectClosedEventHandler;
    event SimulationStarting: SimulationStartingEventHandler;
    event SimulationStarted: SimulationStartedEventHandler;
    event SimulationAdvance: SimulationAdvanceEventHandler;
    event SimulationStopped: SimulationStoppedEventHandler;
    event SimulationEnded: SimulationEndedEvent;
    event TsmApplicationShutdown: TsmApplicationShutdownEventHandler;
  end;

  [COM, Guid('{D305FC5D-70F8-466F-ACEF-BAEDBAB5E6B4}')]
  ITsmSensorEventSink = public interface(ITsmEventSink)
    event VehicleEnter: VehicleEnterEventHandler;
    event VehicleLeave: VehicleLeaveEventHandler;
  end;

  [COM, Guid('1D0F3CEF-C140-4F40-A003-990D65DFC836')])]
  ITsmSignalEventSink = public interface(ITsmEventSink)
    event SignalPlanStarted: SignalPlanStartedEventHandler;
    event SignalPlanEnded: SignalPlanEndedEventHandler;
    event SignalStateChanged: SignalStateChangedEventHandler;
    event HotFaresInitialized: HotFaresInitializedEventHandler;
    event HotFaresReleased: HotFaresReleasedEvent;
  end;

  [COM, Guid('{0EB7A5CB-EEB5-498B-A6AC-B2663DCD4818}')]
  ITsmVehicleEventSink = public interface(ITsmEventSink)
    event Departed: DepartedEventHandler;
    event Parked: ParkedEventHandler;
    event Stalled: StalledEventHandler;
    event Arrived: ArrivedEventHandler;
    event EnterLane: EnterLaneEventHandler;
    event EnterSegment: EnterSegmentEventHandler;
    event EnterLink: EnterLaneEventHandler;
    event PathChanged: PathChangedEventHandler;
    event EnterTransitStop: EnterTransitStopEventHandler;
    event AvlUpdate: AvlUpdateEventHandler;
    event CalculateLinkCost: CalculateLinkCostEventHandler;
    event GetPropertyValue: GetPropertyValueEventHandler;
    event SetPropertyValue: SetPropertyValueEventHandler;
  end;

  TsmEventSink<T> = public abstract class(ITsmEventSink)
  private
    finalizer;
    begin
      DisconnectEvents;
      fEventSource := nil;
    end;
    const cUndefinedCoookie = 0;
    var fCookie: DWORD;
    var fEventSource: IUnknown;
    var fGuid: GUID;
  protected
    method ConnectEvents;
    begin
      if IsConnected then exit;
      InterfaceConnect(fEventSource, var fGuid, Self, var fCookie);
    end;

    method DisconnectEvents;
    begin
      if not IsConnected then exit;
      InterfaceDisconnect(fEventSource, var fGuid, fCookie);
      fCookie := cUndefinedCoookie;
    end;

    method GetEventSinkType: TsmEventSinkType; virtual; abstract;
  public
    constructor(aEventSource: IUnknown);
    begin
      fCookie := cUndefinedCoookie;
      fEventSource := aEventSource;
      fGuid := guidOf(T);
    end;
  public
    property ConnectionID: Int32
      read begin
        exit fCookie;
      end;
    property IsConnected: Boolean
      read begin
        exit (fCookie > cUndefinedCoookie);
      end;
    property EventSinkType: TsmEventSinkType
      read begin
        result := GetEventSinkType();
      end;
  end;

  TsmSimulationEventSink = public class(TsmEventSink<_ISimulationEvents>, ITsmSimulationEventSink, _ISimulationEvents)
  {$REGION '_ISimulationEvents'}
  private
    [CallingConvention(CallingConvention.Stdcall)]
    method OnProjectOpened(const aProjectFileName: OleString): HRESULT;
    begin
      if assigned(ProjectOpened) then
        ProjectOpened(aProjectFileName);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStarting(aRunSeqID: Int16; aTsmRunType: TsmRunType; aIsInPreload: VARIANT_BOOL): HRESULT;
    begin
      if assigned(SimulationStarting) then
        SimulationStarting(aRunSeqID, aTsmRunType, aIsInPreload);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStarted: HRESULT;
    begin
      if assigned(SimulationStarted) then
        SimulationStarted();
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnAdvance(aTime: Double; out aNextCallbackTime: Double): HRESULT;
    begin
      if assigned(SimulationAdvance) then
        SimulationAdvance(aTime, out aNextCallbackTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationStopped(aTsmState: TsmState): HRESULT;
    begin
      if assigned(SimulationStopped) then
        SimulationStopped(aTsmState);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSimulationEnded(aTsmState: TsmState): HRESULT;
    begin
      if assigned(SimulationEnded) then
        SimulationEnded(aTsmState);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnProjectClosed: HRESULT;
    begin
      if assigned(ProjectClosed) then
        ProjectClosed();
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnTsmApplicationShutdown: HRESULT;
    begin
      if assigned(TsmApplicationShutdown) then
        TsmApplicationShutdown();
      result := S_OK;
    end;
  {$ENDREGION}
  protected
    method GetEventSinkType: TsmEventSinkType; override;
    begin
      exit TsmEventSinkType.Simulation;
    end;
  public
    event ProjectOpened: ProjectOpenedEventHandler;
    event ProjectClosed: ProjectClosedEventHandler;
    event SimulationStarting: SimulationStartingEventHandler;
    event SimulationStarted: SimulationStartedEventHandler;
    event SimulationAdvance: SimulationAdvanceEventHandler;
    event SimulationStopped: SimulationStoppedEventHandler;
    event SimulationEnded: SimulationEndedEvent;
    event TsmApplicationShutdown: TsmApplicationShutdownEventHandler;
  end;

  TsmSensorEventSink = public class(TsmEventSink<_ISensorEvents>, ITsmSensorEventSink, _ISensorEvents)
  {$REGION '_ISensorEvents'}
  private
    [CallingConvention(CallingConvention.Stdcall)]
    method OnVehicleEnter(aSensorID: Integer; aVehicleID: Integer; aActivateTime: Double; aSpeed: Single): HRESULT;
    begin
      if assigned(VehicleEnter) then
        VehicleEnter(aSensorID, aVehicleID, aActivateTime, aSpeed);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnVehicleLeave(aSensorID: Integer; aVehicleID: Integer; aDeactivateTime: Double;  aSpeed: Single): HRESULT;
    begin
      if assigned(VehicleLeave) then
        VehicleLeave(aSensorID, aVehicleID, aDeactivateTime, aSpeed);
      result := S_OK;
    end;
  {$ENDREGION}
  protected
    method GetEventSinkType: TsmEventSinkType; override;
    begin
      exit TsmEventSinkType.Sensor;
    end;
  public
    event VehicleEnter: VehicleEnterEventHandler;
    event VehicleLeave: VehicleLeaveEventHandler;
  end;

  TsmSignalEventSink = public class(TsmEventSink<_ISignalEvents>, ITsmSignalEventSink, _ISignalEvents)
  {$REGION '_ISignalEvents Methods'}
  private
    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalPlanStarted(aCookie: Integer; aControllClass: TsmControlClass; aIDs: VARIANT): HRESULT;
    begin
      if assigned(SignalPlanStarted) then
        SignalPlanStarted(aCookie, aControllClass, aIDs);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalPlanEnded(aCookie: Integer): HRESULT;
    begin
      if assigned(SignalPlanEnded) then
        SignalPlanEnded(aCookie);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnHotFaresInitialized(aEntranceID: Integer): HRESULT;
    begin
      if assigned(HotFaresInitialized) then
        HotFaresInitialized(aEntranceID);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnHotFaresReleased(aEntranceID: Integer): HRESULT;
    begin
      if assigned(HotFaresReleased) then
        HotFaresReleased(aEntranceID);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSignalStateChanged(aSignalID: Integer; aTime: Double; aSignalState: TsmSignalState): HRESULT;
    begin
      if assigned(SignalStateChanged) then
        SignalStateChanged(aSignalID, aTime, aSignalState);
      result := S_OK;
    end;
  {$ENDREGION}
  protected
    method GetEventSinkType: TsmEventSinkType; override;
    begin
      exit TsmEventSinkType.Signal;
    end;
  public
    event SignalPlanStarted: SignalPlanStartedEventHandler;
    event SignalPlanEnded: SignalPlanEndedEventHandler;
    event SignalStateChanged: SignalStateChangedEventHandler;
    event HotFaresInitialized: HotFaresInitializedEventHandler;
    event HotFaresReleased: HotFaresReleasedEvent;
  end;

  TsmVehicleEventSink = public class(TsmEventSink<_IVehicleEvents>, ITsmVehicleEventSink, _IVehicleEvents)
  {$REGION '_IVehicleEvents Methods'}
  private
    [CallingConvention(CallingConvention.Stdcall)]
    method OnDeparted(aVehicleID: Integer; aTime: Double): HRESULT;
    begin
      if assigned(Departed) then
        Departed(aVehicleID, aTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnParked(aVehicleID: Integer; aTime: Double): HRESULT;
    begin
      if assigned(Parked) then
        Parked(aVehicleID, aTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnStalled(aVehicleID: Integer; aTime: Double; aStalled: VARIANT_BOOL): HRESULT;
    begin
      if assigned(Stalled) then
        Stalled(aVehicleID, aTime, aStalled);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnArrived(aVehicleID: Integer; aTime: Double): HRESULT;
    begin
      if assigned(Arrived) then
        Arrived(aVehicleID, aTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterLane(const aVehicle: ITsmVehicle; aLaneID: Integer; aLaneEntryTime: Double): HRESULT;
    begin
      if assigned(EnterLane) then
        EnterLane(aVehicle, aLaneID, aLaneEntryTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterSegment(const aVehicle: ITsmVehicle; aSegmentID: Integer; aSegmentEntryTime: Double): HRESULT;
    begin
      if assigned(EnterSegment) then
        EnterSegment(aVehicle, aSegmentID, aSegmentEntryTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterLink(const aVehicle: ITsmVehicle; aLinkID: Integer; aLinkEntryTime: Double): HRESULT;
    begin
      if assigned(EnterLink) then
        EnterLink(aVehicle, aLinkID, aLinkEntryTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnPathChanged(const aVehicle: ITsmVehicle; aPathID: Integer; aPosition: Integer; aTime: Double): HRESULT;
    begin
      if assigned(PathChanged) then
        PathChanged(aVehicle, aPathID,aPosition, aTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnEnterTransitStop(aTime: Double; const aVehicle: ITsmVehicle; const aRoute: ITsmRoute;
        const aStop: ITsmStop; aMaxCapacity: Int16; aPassengers: Int16; aDelay: Single;
        aDefaultDwellTime: Single; out aDwellTime: Single): HRESULT;
    begin
      if assigned(EnterTransitStop) then
        EnterTransitStop(aTime, aVehicle, aRoute, aStop, aMaxCapacity, aPassengers,
          aDelay, aDefaultDwellTime, out aDwellTime);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnAvlUpdate(const aVehicle: ITsmVehicle; aVehicleClassIndex: Int16; aOccupancy: Int16;
        aPreemptionTypeIndex: Int16; var aCoordinate: STsmCoord3): HRESULT;
    begin
      if assigned(AvlUpdate) then
        AvlUpdate(aVehicle, aVehicleClassIndex, aOccupancy, aPreemptionTypeIndex, var aCoordinate);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnCalculateLinkCost(aVehicleClassIndex: Int16; aOccupancy: Int16; aDriverGroupIndex: Int16;
        aVehicleType: TsmVehicleType; aLinkEntryTime: Double; const aFromLink: ITsmLink;
        const aLink: ITsmLink; var aValue: Single): HRESULT;
    begin
      if assigned(CalculateLinkCost) then
        CalculateLinkCost(aVehicleClassIndex, aOccupancy, aDriverGroupIndex, aVehicleType,
          aLinkEntryTime, aFromLink, aLink, var aValue);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnGetPropertyValue(const aVehicle: ITsmVehicle; aColumnIndex: Int16; out aValue: VARIANT): HRESULT;
    begin
      if assigned(GetPropertyValue) then
        GetPropertyValue(aVehicle, aColumnIndex, out aValue);
      result := S_OK;
    end;

    [CallingConvention(CallingConvention.Stdcall)]
    method OnSetPropertyValue(const aVehicle: ITsmVehicle; aColumnIndex: Int16; aValue: VARIANT): HRESULT;
    begin
      if assigned(SetPropertyValue) then
        SetPropertyValue(aVehicle, aColumnIndex, aValue);
      result := S_OK;
    end;
  {$ENDREGION}
  protected
    method GetEventSinkType: TsmEventSinkType; override;
    begin
      exit TsmEventSinkType.Vehicle;
    end;
  public
    event Departed: DepartedEventHandler;
    event Parked: ParkedEventHandler;
    event Stalled: StalledEventHandler;
    event Arrived: ArrivedEventHandler;
    event EnterLane: EnterLaneEventHandler;
    event EnterSegment: EnterSegmentEventHandler;
    event EnterLink: EnterLaneEventHandler;
    event PathChanged: PathChangedEventHandler;
    event EnterTransitStop: EnterTransitStopEventHandler;
    event AvlUpdate: AvlUpdateEventHandler;
    event CalculateLinkCost: CalculateLinkCostEventHandler;
    event GetPropertyValue: GetPropertyValueEventHandler;
    event SetPropertyValue: SetPropertyValueEventHandler;
  end;

  TsmEventSinkType = public enum (
    Undefined,
    Simulation,
    Signal,
    Sensor,
    Vehicle,
    All
  );

  TsmEventSinkTypes = set of TsmEventSinkType;

  [COM, Guid('{5CB6D9ED-80C5-4612-9D4B-FE36A6B3B1E3}')]
  ITsmEventSinkManager = public interface(IUnknown)
    method Connect(aEventSinkTypes: TsmEventSinkTypes);
    method Disconnect(aEventSinkTypes: TsmEventSinkTypes);
    method GetEventSink(aType: TsmEventSinkType): ITsmEventSink;
  end;

  TsmEventSinkManager = public class(ITsmEventSinkManager)
  private
    finalizer;
    begin
      Disconnect([TsmEventSinkType.All]);
      fEventSinkMap.Clear;
    end;

    method SetEventSinkConnection(aEventSinkTypes: TsmEventSinkTypes; aConnected: Boolean);
    begin
      for lType in fEventSinkMap.Keys do begin
        if (lType in aEventSinkTypes) or (TsmEventSinkType.All in aEventSinkTypes) then begin
          if aConnected then
            fEventSinkMap[lType].ConnectEvents()
          else
            fEventSinkMap[lType].DisconnectEvents();
        end;
      end;
    end;

    var fEventSinkMap: Dictionary<TsmEventSinkType, ITsmEventSink>;
  protected
    method Connect(aEventSinkTypes: TsmEventSinkTypes);
    begin
      SetEventSinkConnection(aEventSinkTypes, true);
    end;

    method Disconnect(aEventSinkTypes: TsmEventSinkTypes);
    begin
      SetEventSinkConnection(aEventSinkTypes, false);
    end;

    method GetEventSink(aType: TsmEventSinkType): ITsmEventSink;
    begin
      if aType in [TsmEventSinkType.Undefined, TsmEventSinkType.All] then
        exit nil;
      result := fEventSinkMap[aType];
    end;
  public
    constructor(aTsmApp: ITsmApplication);
    begin
      fEventSinkMap := new Dictionary<TsmEventSinkType, ITsmEventSink>;
      fEventSinkMap.Add(TsmEventSinkType.Simulation,
        new TsmSimulationEventSink(aTsmApp));
      fEventSinkMap.Add(TsmEventSinkType.Signal,
        new TsmSignalEventSink(aTsmApp));
      fEventSinkMap.Add(TsmEventSinkType.Sensor,
        new TsmSensorEventSink(aTsmApp));
      fEventSinkMap.Add(TsmEventSinkType.Vehicle,
        new TsmVehicleEventSink(aTsmApp));
    end;
  end;

end.