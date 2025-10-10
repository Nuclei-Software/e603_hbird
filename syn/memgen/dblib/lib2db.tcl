
foreach lib [glob *.lib] {
    read_lib $lib
    set out_name [file rootname [file tail $lib]]
    set lib_name [get_attribute [get_lib *] name]
    write_lib -format db ${lib_name} -output ${out_name}.db
    remove_lib  -all
}
exit
