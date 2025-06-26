set lib_dir    "../../../platform/ASAP7/lib"
set lef_dir    "../../../platform/ASAP7/lef"
set def_file   "6_final.def"
set odb_file   "6_final.odb"
set sdc_file   "6_final.sdc"
set rpt_file   "timing_report.rpt"

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
read_def $def_file
read_sdc $sdc_file
b
report_checks -path_delay min_max -fields {slew cap input_pins} -digits 4 > $rpt_file

puts "Timing report written to $rpt_file"
exit
