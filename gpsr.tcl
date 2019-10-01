Agent/GPSR set sport_        0
Agent/GPSR set dport_        0

puts "GPSR configuration file"

# ======================================================================

proc create-gpsr-routing-agent { node id } {
    global ns_ ragent_ opt

    #
    #  Create the Routing Agent and attach it to port 255.
    #
    #set ragent_($id) [new $opt(ragent) $id]
    set ragent_($id) [new Agent/GPSR]
    set ragent $ragent_($id)

    ## setup address (supports hier-addr) for dsdv agent 
    ## and mobilenode
    set addr [$node node-addr]
    
    $ragent addr $addr
    $ragent node $node
    if [Simulator set mobile_ip_] {
	$ragent port-dmux [$node set dmux_]
    }
    $node addr $addr
    $node set ragent_ $ragent
    $node attach $ragent [Node set rtagent_port_]
    set j [expr $id/($opt(nn)+$opt(nn))]
    $ns_ at $opt(start) "$ragent_($id) turnon $j" 
    $ns_ at $opt(stop) "$ragent_($id) turnoff"


}


proc gpsr-create-mobile-node { id args } {
	global ns ns_ chan prop topo opt node_

	set ns_ [Simulator instance]
    set node_($id) [new Node/MobileNode]
	set node $node_($id)
	$node random-motion 0		;# disable random motion
	$node topography $topo
    
	# XXX Activate energy model so that we can use sleep, etc. But put on 
	# a very large initial energy so it'll never run out of it.
	#if [info exists opt(energy)] {
	#	$node addenergymodel [new $opt(energy) $node 1000 0.5 0.2]
	#}

	#
	# This Trace Target is used to log changes in direction
	# and velocity for the mobile node.
	#

    
	if ![info exist inerrProc_] {
		set inerrProc_ ""
	}
	if ![info exist outerrProc_] {
		set outerrProc_ ""
	}
	if ![info exist FECProc_] {
		set FECProc_ ""
	}

	$node add-interface $chan $prop $opt(ll) $opt(mac)	\
	    $opt(ifq) $opt(ifqlen) $opt(netif) $opt(ant) \
	    $topo $inerrProc_ $outerrProc_ $FECProc_ 
    
	#
	# Create a Routing Agent for the Node
	#
	create-gpsr-routing-agent $node $id
    
    $ns_ at $opt(start) "$node_($id) start"
    $ns_ at $opt(stop).000000001 "$node_($id) reset";
    return $node
}
proc create-bus { id } {
	global ragent_ opt	
	gpsr-create-mobile-node $id
	$ragent_($id) set_node_type $opt(BUS)
}
proc create-rsu { rsu_ x_ y_ } {
	global ragent_ opt node_
	set id [expr $opt(bus)+$rsu_]
	gpsr-create-mobile-node $id
    	$ragent_($id) set_node_type $opt(RSU)
	$node_($id) set X_ $x_
	$node_($id) set Y_ $y_
}
