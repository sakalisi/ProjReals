package 'GPS Trade Study' {
    private import ScalarValues::Real;
    private import TradeStudies::*;

    part def GPS;
    part Garmin_DriveSmart_86 : GPS;
    part Teltonika_FMB920 : GPS;


    calc def AccuracyRollup { in gps : GPS; return : Real; }
    calc def PowerConsumptionRollup { in gps : GPS; return : Real; }
    calc def SignalStabilityRollup { in gps : GPS; return : Real; }
    calc def CostRollup { in gps : GPS; return : Real; }

    calc def GPSEvaluation { 
        in accuracy : Real;
        in powerConsumption : Real;
        in signalStability : Real;
        in cost : Real;
        return evaluation : Real;


    }

    analysis gpsTradeStudy : TradeStudy {
        subject : GPS = (Garmin_DriveSmart_86, Teltonika_FMB920);
        objective : MaximizeObjective;

        calc :>> evaluationFunction {
            in part aGPS :>> alternative : GPS;

            calc accuracyRollup: AccuracyRollup { in gps = aGPS; return accuracy; }
            calc powerConsumptionRollup: PowerConsumptionRollup { in gps = aGPS; return powerConsumption; }
            calc signalStabilityRollup: SignalStabilityRollup { in gps = aGPS; return signalStability; }
            calc costRollup: CostRollup { in gps = aGPS; return cost; }

            return :>> result : Real = GPSEvaluation(
                accuracyRollup.accuracy, powerConsumptionRollup.powerConsumption, 
                signalStabilityRollup.signalStability, costRollup.cost
            );
        }

        return part :>> selectedAlternative : GPS;
    }

}