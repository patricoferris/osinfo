osinfo
------

Hardcoded operating-system information provided as OCaml modules. This library uses `osrelease` to get each platform's details then a Github workflow to generate them by actually running a small generator script in different OS environments, collecting the outputs and build the module. 
