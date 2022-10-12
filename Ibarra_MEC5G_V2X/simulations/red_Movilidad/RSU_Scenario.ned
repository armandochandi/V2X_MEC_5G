
package ibarra_mec5g_v2x.simulations.red_Movilidad;

import org.car2x.veins.base.connectionManager.ConnectionManager;
import org.car2x.veins.base.modules.BaseWorldUtility;
import org.car2x.veins.modules.mobility.traci.TraCIScenarioManager*;
import org.car2x.veins.modules.obstacle.ObstacleControl;
import org.car2x.veins.modules.world.annotations.AnnotationManager;
import org.car2x.veins.nodes.Car;
import org.car2x.veins.nodes.RSU;
import org.car2x.veins.visualizer.roads.RoadsCanvasVisualizer;

network RSU_Scenario
{
    parameters:
        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)
       @display("bgb=$playgroundSizeX,$playgroundSizeY"); //NO CAMBIAR 
    submodules:
        obstacles: ObstacleControl {
            @display("p=176,128");
        }
        annotations: AnnotationManager {
            @display("p=60,128");
        }
        connectionManager: ConnectionManager {
            parameters:
                @display("p=60,39;i=abstract/multicast");
        }
        world: BaseWorldUtility {
            parameters:
                playgroundSizeX = veins_eval_by_version(veins_omnetpp_buildnum(), "playgroundSizeX", 1525, "parent.playgroundSizeX");
                playgroundSizeY = veins_eval_by_version(veins_omnetpp_buildnum(), "playgroundSizeY", 1525, "parent.playgroundSizeY");
                playgroundSizeZ = veins_eval_by_version(veins_omnetpp_buildnum(), "playgroundSizeZ", 1525, "parent.playgroundSizeZ");
                @display("p=176,39;i=misc/globe");
        }
        manager: TraCIScenarioManagerLaunchd {
            parameters:
                @display("p=281,39");
        }
        roadsCanvasVisualizer: RoadsCanvasVisualizer {
            @display("p=420,39");
        }
        node[0]: Car {
            @display("p=242,214");
        }
        rsu[1]: RSU {
            @display("p=346,214;i=veins/sign/yellowdiamond;is=vs");
        }

    connections allowunconnected:
}

