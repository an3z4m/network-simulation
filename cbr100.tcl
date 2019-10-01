
# GPSR routing agent settings
#$ns_ at 0.1 "$ragent_(0) give_neighbors"
for {set i 0} {$i < $opt(nn)} {incr i} {
set j [expr $i*0.0029]
#   $ns_ at $j "$ragent_($i) turnon $j"
}
#$ragent_(4) turnon 0.4
proc connect-and-send { x y i send_time } {
	global ns_ node_ nb_packet
#	set x [expr {int(rand()*$opt(nn))}];
	set null_($i) [new Agent/Null]
	$ns_ attach-agent $node_($y) $null_($i)

#	set y [expr {int(rand()*$opt(nn))}];
	set udp_($i) [new Agent/UDP]
	$ns_ attach-agent $node_($x) $udp_($i)


	set cbr_($i) [new Application/Traffic/CBR]
	#$cbr_($i) set packetSize_ 32
	$cbr_($i) set interval_ 1.0
	$cbr_($i) set random_ false
	#    $cbr_(1) set maxpkts_ 100
	$cbr_($i) attach-agent $udp_($i)
	$ns_ connect $udp_($i) $null_($i)


	set msg " $x will send $nb_packet packets to $y at $send_time ";
	puts stdout $msg

	$ns_ at $send_time "$cbr_($i) start"
	$ns_ at [expr $send_time+$nb_packet] "$cbr_($i) stop"
}

#$nb_agent
for {set i 0} {$i < $nb_agent} {incr i} {
	
	set x [expr {int(rand()*$opt(bus))}];
	set y [expr {int(rand()*$opt(bus))}];

	set send_time [expr {int(0.75 * rand()*($opt(stop)-$opt(start))+$opt(start))}]
	# 20 seconds for remaining packets to be delivered
	connect-and-send $x $y $i $send_time
}
#$ns_ at 5.0 "$ragent_(5) test"

# 36 va envoyer 1 packets a 41 
# 1 va envoyer 1 packets a 35 	
#connect-and-send 36 41 1
#connect-and-send 24 15 1
#connect-and-send 5 30 1

#for {set i 0} {$i < $opt(nn)} {incr i} { $ns_ at $opt(stop) "$ragent_($i) turnoff" }

