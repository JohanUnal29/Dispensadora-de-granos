
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name DISPENDADOR -dir "C:/Users/57313/Desktop/digital/DISPENDADOR/planAhead_run_2" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/57313/Desktop/digital/DISPENDADOR/PRINCIPAL.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/57313/Desktop/digital/DISPENDADOR} }
set_property target_constrs_file "SALIDA.ucf" [current_fileset -constrset]
add_files [list {SALIDA.ucf}] -fileset [get_property constrset [current_run]]
link_design
