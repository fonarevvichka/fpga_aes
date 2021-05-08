if {[catch {

# define run engine funtion
source [file join {C:/Users/benja/3D Objects} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/benja/es4/final_local/aes_bench"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- aes_bench_impl_1.vm aes_bench_impl_1.ldc
run_engine_newmsg synthesis -f "aes_bench_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o aes_bench_impl_1_syn.udb aes_bench_impl_1.vm] "C:/Users/benja/es4/final_local/aes_bench/impl_1/aes_bench_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
