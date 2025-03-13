package useCases {
	private import BaseFunctions::*;
	private import CollectionFunctions::*;
	public import ElectricVehicleUsages::*;
	public import ElectricVehicleDefinitions::*;
	public import VehicleActionDefinition::*;
	public import Requirements_EV::*;
	
	package remote {
		requirement connectReq : ConnectivityRequirement;
		requirement modesSwapsReq : ModeSwitchRequirement;
		requirement UIShowReq : UIRequirement;
		requirement powerReq : PowerRequirement;
		
		use case def remote_vehicle_dropoff {
			objective transportObjective {
				doc /* Send and drive the passenger safely to the aforementioned destination */
				require connectReq;
				require modesSwapsReq;
				require UIShowReq;
				require powerReq;
			}
			
			subject vehicle : E_Vehicle;
			actor environment;
			actor sattelite;
			actor passenger [0..4];
            include use case followGPS:FollowGPS;
		}
        use case followGPS: FollowGPS {
        		action receiveCmd : ReceiveRemoteCommand;
        		then action parseCmd : ParseRemoteCommand;
        		then action executeCmd : ExecuteVehicleController;
        }
        use case def FollowGPS {
	        	subject vehicle : E_Vehicle;
	        	actor GPSSat [0..5];
	        	actor comms5G;
	        	actor commsWifi;
	        	actor commsBT;
	        	assert constraint {GPSSat->size() >= 2 and comms5G != null and commsWifi != null and commsBT != null}
        } 
	}
}