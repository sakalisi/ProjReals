package 'Battery Trade Study' {
    private import ScalarValues::*;
    private import TradeStudies::*;
	private import ControlFunctions::*;
    

    part def Battery;
    part Lithium_Iron_Phosphate_Battery : Battery;
    part Lithium_Nickel_Cobalt_Aluminum_Oxide_Battery : Battery;

    calc def CapacityRollup { in battery : Battery; return : Real; }
    calc def ChargingTimeRollup { in battery : Battery; return : Real; }
    calc def LifespanRollup { in battery : Battery; return : Real; }
    calc def CostRollup { in battery : Battery; return : Real; }

    calc def BatteryEvaluation { 
        in capacity : Real;
        in chargingTime : Real;
        in lifespan : Real;
        in cost : Real;
        return evaluation : Real;
 
    }

    analysis batteryTradeStudy : TradeStudy {
        subject : Battery = (Lithium_Iron_Phosphate_Battery, Lithium_Nickel_Cobalt_Aluminum_Oxide_Battery);
        objective : MaximizeObjective;

        calc :>> evaluationFunction {
            in part aBattery :>> alternative : Battery;

            calc capacityRollup: CapacityRollup { in battery = aBattery; return capacity; }
            calc chargingTimeRollup: ChargingTimeRollup { in battery = aBattery; return chargingTime; }
            calc lifespanRollup: LifespanRollup { in battery = aBattery; return lifespan; }
            calc costRollup: CostRollup { in battery = aBattery; return cost; }

            return :>> result : Real = BatteryEvaluation(
                capacityRollup.capacity, chargingTimeRollup.chargingTime, 
                lifespanRollup.lifespan, costRollup.cost
            );
        }

        return part :>> selectedAlternative : Battery;
    }

}