open Osinfo

let unixes =
  [
    ("Ubuntu", Os.Ubuntu18_04.v);
    ("MacOS", Os.Homebrew10_15_7.v);
    ("Alpine", Os.Alpine3_12_3.v);
    ("Debian", Os.Debian10.v);
    ("Centos", Os.Centos8.v);
    ("Fedora", Os.Fedora32.v);
  ]

let env t =
  Opam_0install.Dir_context.std_env ~arch:t.Types.arch ~os:t.os
    ~os_family:t.os_family ~os_distribution:t.os_distribution
    ~os_version:t.os_version ()

let unix_context (name, v) =
  ( name,
    Opam_0install.Dir_context.create "/tmp/opam-repository/packages"
      ~constraints:OpamPackage.Name.Map.empty ~env:(env v) )

let windows_context =
  ( "windows",
    Opam_0install.Dir_context.create "/tmp/opam-repository-mingw/packages"
      ~constraints:OpamPackage.Name.Map.empty ~env:(env Os.Win3210_0_17763.v) )

module Solver = Opam_0install.Solver.Make (Opam_0install.Dir_context)

let test_packages = [ "yaml" ]

let () =
  let build (name, ctx) =
    let result =
      Solver.solve ctx (List.map OpamPackage.Name.of_string test_packages)
    in
    match result with
    | Error e -> print_endline (Solver.diagnostics e)
    | Ok selections ->
        let pkgs = Solver.packages_of_result selections in
        Fmt.(
          pf stdout "Solved for %s: [ %a ]\n\n" name (list ~sep:comma string)
            (List.map OpamPackage.to_string pkgs))
  in
  List.iter build (List.map unix_context unixes);
  build windows_context
