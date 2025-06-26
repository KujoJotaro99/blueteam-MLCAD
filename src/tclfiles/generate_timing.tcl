if {$argc > 0} {
    set tech [expr {$argc>0 ? $argv0 : $::env(TECH)}]
    set design [expr {$argc>1 ? $argv1 : $::env(DESIGN)}]   
} else {
    set tech "ASAP7"
    set design "ac97_top"
}


set lib_dir    "../../platform/$tech/lib"
set lef_dir    "../../platform/$tech/lef"
set def_file   "../../designs/$design/Results/6_final.def"
set odb_file   "../../designs/$design/Results/6_final.odb"
set sdc_file   "../../designs/$design/Results/6_final.sdc"
set rpt_file   "../../designs/$design/Results/timing_report.rpt"

foreach libfile [glob "$lib_dir/*.lib"] {
    read_liberty $libfile
}

foreach leffile [glob "$lef_dir/*.lef"] {
    if {[string match "*tech*" $leffile]} {
        continue
    }
    read_lef $leffile
}
read_db $odb_file
#read_def $def_file
read_sdc $sdc_file

report_checks -path_delay min_max -fields {slew cap input_pins} -digits 4 > $rpt_file

puts "Timing report written to $rpt_file"
exit
