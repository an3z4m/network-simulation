
set opt(RSU) 1
set opt(BUS) 0



set ns_home "/opt/ns2/ns-allinone-2.35/ns-2.35/"	
# ======================================================================
# Default Script Options
# ======================================================================
set opt(chan)		Channel/WirelessChannel
set opt(prop)		Propagation/TwoRayGround
set opt(netif)		Phy/WirelessPhy
set opt(mac)		Mac/802_11
set opt(ifq)		Queue/DropTail/PriQueue	;# for dsdv
set opt(ll)		LL
set opt(ant)            Antenna/OmniAntenna

set opt(x)		5400		;# X dimension of the topography
set opt(y)		5400		;# Y dimension of the topography
set opt(cp)		"./cbr100.tcl"
set opt(sc)		"./lagh34.tcl"

set opt(ifqlen)		10000		;# max packet in ifq
#################################################################################
set opt(bus)		34		;# number of buses
set opt(rsu)		3		;# number of nodes
set opt(nn)			[expr  $opt(bus) + $opt(rsu)]		;# number of nodes
###############################################################################""
#### binding information

set max_nodes_ [expr $opt(bus)+$opt(rsu)]

Agent/GPSR set bus_number_ $opt(bus)
Agent/GPSR set rsu_number_ $opt(rsu)
Agent/GPSR set max_nodes_ [expr $opt(bus)+$opt(rsu)]

Agent/GPSR set max_range_ 300
##############################
set opt(seed)		2.3214576

##########################################################################"
set duration		1500	;	# 120 seconds
set opt(start)		2000		;# simulation time
set opt(stop)		[expr $opt(start) + $duration]		;# simulation time
##################################################################################

set nb_agent [expr  $opt(bus) * 10];
set nb_packet 1;


set opt(tr)		trace.tr		;# trace file
set opt(nam)            nam.out.tr
set opt(rp)             gpsr		;# routing protocol script (dsr or dsdv)
set opt(lm)             "off"		;# log movement

# ======================================================================

LL set mindelay_		50us
LL set delay_			25us
LL set bandwidth_		0	;# not used

Agent/Null set sport_		0
Agent/Null set dport_		0

Agent/CBR set sport_		0
Agent/CBR set dport_		0

Agent/TCPSink set sport_	0
Agent/TCPSink set dport_	0

Agent/TCP set sport_		0
Agent/TCP set dport_		0
Agent/TCP set packetSize_	1460

Queue/DropTail/PriQueue set Prefer_Routing_Protocols    1

# unity gain, omni-directional antennas
# set up the antennas to be centered in the node and 1.5 meters above it
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0

# Initialize the SharedMedia interface with parameters to make
# it work like the 914MHz Lucent WaveLAN DSSS radio interface
Phy/WirelessPhy set CPThresh_ 10.0
Phy/WirelessPhy set CSThresh_ 1.559e-11
Phy/WirelessPhy set RXThresh_ 3.652e-10
Phy/WirelessPhy set Rb_ 2*1e6
Phy/WirelessPhy set freq_ 914e+6 
Phy/WirelessPhy set L_ 1.0


# The transimssion radio range 
#Phy/WirelessPhy set Pt_ 6.9872e-4    ;# ?m
#Phy/WirelessPhy set Pt_ 8.5872e-4    ;# 40m
#Phy/WirelessPhy set Pt_ 1.33826e-3   ;# 50m
#Phy/WirelessPhy set Pt_ 7.214e-3     ;# 100m
#Phy/WirelessPhy set Pt_ 0.2818       ;# 250m
Phy/WirelessPhy set Pt_ 0.58432007       ;# 300m
# ======================================================================


#802.11p setting:
#The Antenna height of transmitter and receiver is 1.5m.
#The propagation model is TwoRayGround model.
# set up the antennas to be centered in the node and 1.5 meters above it
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0 ;# Transmit antenna gain
Antenna/OmniAntenna set Gr_ 1.0 ;# Receive antenna gain
#802.11p parameters
Phy/WirelessPhyExt set CSThresh_ 3.162e-12 ;#-85 dBm Wireless interface #sensitivity ;#(sensitivity defined in the standard)
Phy/WirelessPhyExt set Pt_ 0.001
Phy/WirelessPhyExt set freq_ 5.9e+9
Phy/WirelessPhyExt set noise_floor_ 1.26e-13 ;#-99 dBm for 10MHz bandwidth
Phy/WirelessPhyExt set L_ 1.0 ;#default radio circuit gain/loss
Phy/WirelessPhyExt set PowerMonitorThresh_ 6.310e-14 ;#-102dBm power monitor sensitivity
Phy/WirelessPhyExt set HeaderDuration_ 0.000040 ;#40 us
Phy/WirelessPhyExt set BasicModulationScheme_ 0
Phy/WirelessPhyExt set PreambleCaptureSwitch_ 1
Phy/WirelessPhyExt set DataCaptureSwitch_ 0
Phy/WirelessPhyExt set SINR_PreambleCapture_ 2.5118; ;# 4 dB
Phy/WirelessPhyExt set SINR_DataCapture_ 100.0; ;# 10 dB
Phy/WirelessPhyExt set trace_dist_ 1e6 ;# PHY trace until distance of 1 Mio. km ("infinty")
Phy/WirelessPhyExt set PHY_DBG_ 0
Mac/802_11Ext set CWMin_ 15
Mac/802_11Ext set CWMax_ 1023
Mac/802_11Ext set SlotTime_ 0.000013
Mac/802_11Ext set SIFS_ 0.000032
Mac/802_11Ext set ShortRetryLimit_ 7
Mac/802_11Ext set LongRetryLimit_ 4
Mac/802_11Ext set HeaderDuration_ 0.000040
Mac/802_11Ext set SymbolDuration_ 0.000008
Mac/802_11Ext set BasicModulationScheme_ 0
Mac/802_11Ext set use_802_11a_flag_ true
#Mac/802_11Ext set RTSThreshold_ 2346
Mac/802_11Ext set MAC_DBG_ 0



# Agent/GPSR setting
Agent/GPSR set planar_type_  1   ;#1=GG planarize, 0=RNG planarize
##################################################################################"
Agent/GPSR set hello_period_   1.00001 ;#Hello message period
##############################################################################
Agent/GPSR set nb_packet_envoye_  $nb_packet;
# ======================================================================

proc usage { argv0 }  {
	puts "Usage: $argv0"
	puts "\tmandatory arguments:"
	puts "\t\t\[-x MAXX\] \[-y MAXY\]"
	puts "\toptional arguments:"
	puts "\t\t\[-cp conn pattern\] \[-sc scenario\] \[-nn nodes\]"
	puts "\t\t\[-seed seed\] \[-stop sec\] \[-tr tracefile\]\n"
}


proc getopt {argc argv} {
	global opt
	lappend optlist cp nn seed sc stop tr x y

	for {set i 0} {$i < $argc} {incr i} {
		set arg [lindex $argv $i]
		if {[string range $arg 0 0] != "-"} continue

		set name [string range $arg 1 end]
		set opt($name) [lindex $argv [expr $i+1]]
	}
}
#
#proc log-movement {} {
#    global logtimer ns_ ns
#
#   set ns $ns_
#    source $ns_home/tcl/mobility/timer.tcl
#    Class LogTimer -superclass Timer
#    LogTimer instproc timeout {} {
#	global opt node_;
#	for {set i 0} {$i < $opt(nn)} {incr i} {
#	    $node_($i) log-movement
#	}
#	$self sched 0.1
#    }

#    set logtimer [new LogTimer]
#    $logtimer sched 0.1
#}

# ======================================================================
# Main Program
# ======================================================================
#
# Source External TCL Scripts
#
#source ../lib/ns-mobilenode.tcl

#if { $opt(rp) != "" } {
	#source ../mobility/$opt(rp).tcl
	#} elseif { [catch { set env(NS_PROTO_SCRIPT) } ] == 1 } {
	#puts "\nenvironment variable NS_PROTO_SCRIPT not set!\n"
	#exit
#} else {
	#puts "\n*** using script $env(NS_PROTO_SCRIPT)\n\n";
        #source $env(NS_PROTO_SCRIPT)
#}
#source ../tcl/lib/ns-cmutrace.tcl
source $ns_home/tcl/lib/ns-bsnode.tcl
source $ns_home/tcl/mobility/com.tcl

# do the get opt again incase the routing protocol file added some more
# options to look for
getopt $argc $argv

if { $opt(x) == 0 || $opt(y) == 0 } {
	usage $argv0
	exit 1
}

if {$opt(seed) > 0} {
	puts "Seeding Random number generator with $opt(seed)\n"
	ns-random $opt(seed)
}

#
# Initialize Global Variables
#
set ns_		[new Simulator]
set chan	[new $opt(chan)]
set prop	[new $opt(prop)]
set topo	[new Topography]

set tracefd   [open $opt(tr) w]
#$ns_ trace-all  $tracefd

set namfile [open $opt(nam) w]
#$ns_ namtrace-all $namfile 

$topo load_flatgrid $opt(x) $opt(y)


$prop topography $topo

#
# Create God
#
set god_ [create-god $opt(nn)]


#
#  Create the specified number of nodes $opt(nn) and "attach" them
#  the channel.
#  Each routing protocol script is expected to have defined a proc
#  create-mobile-node that builds a mobile node and inserts it into the
#  array global $node_($i)
#

$ns_ node-config -adhocRouting gpsr \
                 -llType $opt(ll) \
                 -macType $opt(mac) \
                 -ifqType $opt(ifq) \
                 -ifqLen $opt(ifqlen) \
                 -antType $opt(ant) \
                 -propType $opt(prop) \
                 -phyType $opt(netif) \
                 -channelType $opt(chan) \
                 -topoInstance $topo \
                 -agentTrace OFF \
                 -routerTrace OFF \
                 -macTrace OFF \
                 -movementTrace OFF 

source ./gpsr.tcl

for {set i 0} {$i < $opt(bus) } {incr i} {
#    gpsr-create-mobile-node $i
    create-bus $i
}
##nabilStart##
#600:		1357,1641
#nft:		1422,1104
#ghazali:	2466;1885
#gendarmerie:	2550,2080
#CLINIQUE:	3200,2390
#babdzair:	3737,2787
#ute:		2123,2933
#

create-rsu 0 2550 2080
#gendarmerie
create-rsu 1 2123 2933
#ute
create-rsu 2 1357 1641
#600

#create-rsu 3 3737 2787
#babdzair:      3737,2787
#create-rsu 4 1422 1104
#nft:           1422,1104

#create-rsu 5 2466 1885
#ghazali:	2466;1885
#create-rsu 6 3200 2390
#CLINIQUE:	3200,2390

##nabilEnd##

#
# Source the Connection and Movement scripts
#
if { $opt(cp) == "" } {
	puts "*** NOTE: no connection pattern specified."
        set opt(cp) "none"
} else {
	puts "Loading connection pattern..."
	source $opt(cp)
}


#$ns_ at 10.000000000000 "$node_(0) setdest 20.000000000000 20.000000000000 10.000000000000"
#$ns_ at 50.0 "$node_(2) setdest 401.0 401.0 10.0"
#$ns_ at 0.200000000000 "$node_(0) setdest 0.000000000000 100.000000000000 3.594136380721"


#
# Tell all the nodes when the simulation ends
#
#for {set i 0} { $i < $opt(nn) } {incr i} {
#    $ns_ at $opt(stop).000000001 "$node_($i) reset";
#}


$ns_ at $opt(stop).00000001 "puts \"NS EXITING...\" ; $ns_ halt"


if { $opt(sc) == "" } {
	puts "*** NOTE: no scenario file specified."
        set opt(sc) "none"
} else {
	puts "Loading scenario file..."
	source $opt(sc)
	puts "Load complete..."
}

#puts $tracefd "M 0.0 nn $opt(nn) x $opt(x) y $opt(y) rp $opt(rp)"
#puts $tracefd "M 0.0 sc $opt(sc) cp $opt(cp) seed $opt(seed)"
#puts $tracefd "M 0.0 prop $opt(prop) ant $opt(ant)"

puts "Starting Simulation..."

# before calling this function node(0) must exist
proc finish {} {
    global ns_ tracefd namfile
    #$ns_ flush-trace
    close $tracefd
    close $namfile
    exit 0
}

$ns_ at $opt(stop) "finish"

$ns_ run
