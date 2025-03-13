package ElectricVehicleMissionContext {
	private import BaseFunctions::*;
	private import CollectionFunctions::*;
	public import ElectricVehicleUsages::*;
	public import ElectricVehicleDefinitions::*;
	public import VehicleActionDefinition::*;
	public import Requirements_EV::*;
	
	
	package context_defs {
		part vehicle :> E_VehicleTotal;
		
		part def Passenger;
		part def Road;
		part def ModeSelectionUnit {
			item physicalActuatorData;
			
			exhibit state ModesPossible {
				state manual;
				state remote;
				state autonomous;
				state intermediate;
				
				transition manual_to_autonomous
					first manual
					do action combinedMA_Action {
						action autonomousAction : AutonomousDrivingSystem;
						redefines autonomousAction.user_input = Mode::AUTONOMOUS;
					}
					then autonomous;
				transition manual_to_remote
					first manual
					do action combinedMR {
						action RemoteDrive: RemoteDrivingSystem;
						redefines RemoteDrive.user_input = Mode::REMOTE;
					}
					then remote;
				transition manual_to_manual
					first manual
					do send physicalActuatorData via vehicle.HumanDrive.actMan
					then manual;
				transition autonomous_to_autonomous
					first autonomous
					do action combinedAA_Action {
						action autonomousAction : AutonomousDrivingSystem;
						redefines autonomousAction.user_input = Mode::AUTONOMOUS;
					}
					then autonomous;
				transition autonomous_to_manual
					first autonomous
					do send physicalActuatorData via vehicle.HumanDrive.actMan
					then manual;
				transition autonomous_to_remote
					first autonomous
					do action combinedAR {
						action RemoteDrive: RemoteDrivingSystem;
						redefines RemoteDrive.user_input = Mode::REMOTE;
					}
					then remote;
				transition remote_to_manual
					first remote
					do send physicalActuatorData via vehicle.HumanDrive.actMan
					then manual;
				transition remote_to_autonomous
					first remote
					do action combinedRA_Action {
						action autonomousAction : AutonomousDrivingSystem;
						redefines autonomousAction.user_input = Mode::AUTONOMOUS;
					}
					then autonomous;
				transition remote_to_remote
					first remote
					do action combinedRR {
						action RemoteDrive: RemoteDrivingSystem;
						redefines RemoteDrive.user_input = Mode::REMOTE;
					}
					then remote;
			}
		}
	}
}