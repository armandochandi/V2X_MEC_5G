// UNIVERSIDAD TECNICA DEL NORTE 
// FICA - CIERCOM
// AUTOR: CHANDI BRAYAN
// TESIS PREGRADO 
// 2022

// RED DE TRATAMIENTO DE DATOS (CONEXIONES)  


package ibarra_mec5g_v2x.simulations.red5G_NSA;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.StandardHost;
import simu5g.nodes.PgwStandard;
import simu5g.nodes.eNodeB;
import simu5g.world.radio.LteChannelControl;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.Upf;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.mec.MECHost;
import simu5g.nodes.mec.MECOrchestrator.MecOrchestrator;
import simu5g.nodes.mec.UALCMP.UALCMP;
import inet.node.inet.Router;

network red5G_NSA
{
    parameters:
        int numUes = default(0);

        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)
        @display("bgb=735,378");
        
    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=69,93;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=69,176;is=s");
        }
        channelControl: LteChannelControl {
            @display("p=68,24;is=s");
        }
        binder: Binder {
            @display("p=69,249;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=69,318;is=s");
        }
        upf: Upf {
            @display("p=200,300");
        }
        iUpf: Upf {
            @display("p=352,300");
        }
        gNodeB1: gNodeB {
            @display("p=495,300;is=vl");
        }
        ue[numUes]: NRUe {
            @display("p=658,300;i=device/bus_icono");
        }
        //# MEC module
        mecHost: MECHost {
            @display("p=352,211;is=v");
        }

        mecOrchestrator: MecOrchestrator {
            @display("p=200,101;is=v");
        }

        ualcmp: UALCMP {
            @display("p=200,210;i=device/smallrouter");
        }

        eNodeB1: eNodeB {
            @display("p=352,55;is=vl");
        }
        pgw: PgwStandard {
            @display("p=495,55");
        }
        router: Router {
            @display("p=614,55");
        }
        v2xServer: StandardHost {
            @display("p=614,176;i=cloud");
        }
    connections allowunconnected:
        
		// MEC
        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;
        iUpf.pppg++ <--> Eth10G <--> gNodeB1.ppp;
        ualcmp.ppp++ <--> Eth10G <--> upf.filterGate;
        ualcmp.toMecOrchestrator --> mecOrchestrator.fromUALCMP;
        ualcmp.fromMecOrchestrator <-- mecOrchestrator.toUALCMP;
        mecHost.ppp++ <--> Eth10G <--> iUpf.pppg++;

		//EPC
        v2xServer.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNodeB1.ppp;

        // Conexiones X2
        eNodeB1.x2++ <--> Eth10G <--> gNodeB1.x2++;
}
