osinfo
------

Hardcoded operating-system information provided as OCaml modules. This library uses `osrelease` to get each platform's details then a Github workflow to generate them by actually running a small generator script in different OS environments, collecting the outputs and build the module. 

## Why?

In OCaml-CI there is a stage before building and testing on a worker where the dependencies for a given package are solved so they can be passed down in the form of an environment variable `$DEPS`. This dependency generating stage might only happen on one central machine running, say, Linux and using the main opam-repository. It would be nice to abstract this more and be able to solve for Windows on a Linux machine, or MacOS for that matter. In order to do that we need to pass OS variables to the solver which are easy to get if you are running on that particular OS otherwise you need to be given them... Osinfo!