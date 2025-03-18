package 'CPU Trade Study' {
    private import ScalarValues::Real;
    private import TradeStudies::*;

    part def CPU;
    part Intel_Core_i9_13900K : CPU;
    part AMD_Ryzen_7_7700X : CPU;

    calc def PerformanceRollup { in cpu : CPU; return : Real; }
    calc def PowerConsumptionRollup { in cpu : CPU; return : Real; }
    calc def MultitaskingCapabilityRollup { in cpu : CPU; return : Real; }
    calc def CostRollup { in cpu : CPU; return : Real; }

    calc def CPUEvaluation { 
        in performance : Real;
        in powerConsumption : Real;
        in multitasking : Real;
        in cost : Real;
        return evaluation : Real;

    }

    analysis cpuTradeStudy : TradeStudy {
        subject : CPU = (Intel_Core_i9_13900K, AMD_Ryzen_7_7700X);
        objective : MaximizeObjective;

        calc :>> evaluationFunction {
            in part aCPU :>> alternative : CPU;

            calc performanceRollup: PerformanceRollup { in cpu = aCPU; return performance; }
            calc powerConsumptionRollup: PowerConsumptionRollup { in cpu = aCPU; return powerConsumption; }
            calc multitaskingRollup: MultitaskingCapabilityRollup { in cpu = aCPU; return multitasking; }
            calc costRollup: CostRollup { in cpu = aCPU; return cost; }

            return :>> result : Real = CPUEvaluation(
                performanceRollup.performance, powerConsumptionRollup.powerConsumption, 
                multitaskingRollup.multitasking, costRollup.cost
            );
        }

        return part :>> selectedAlternative : CPU;
    }

}