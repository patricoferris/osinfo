open Sexplib
module Sysp = OpamSysPoll

let get err = function Some t -> t | None -> failwith err

let write () =
  let arch = Sysp.arch () |> get "failed getting arch" in
  let os = Sysp.os () |> get "failed getting os" in
  let os_distribution =
    Sysp.os_distribution () |> get "failed getting distribution"
  in
  let os_version = Sysp.os_version () |> get "failed getting version" in
  let os_family = Sysp.os_family () |> get "failed getting family" in
  let v : Osinfo.t = { arch; os; os_family; os_distribution; os_version } in
  let sexp = Osinfo.sexp_of_t v in
  Sexp.pp Format.std_formatter sexp

let format s =
  let ocamlformat = Bos.Cmd.(v "ocamlformat" % "--impl" % "-") in
  Bos.OS.Cmd.(in_string s |> run_io ocamlformat |> out_string)
  |> Rresult.R.get_ok |> fst

let read f =
  let module_name = String.capitalize_ascii in
  let pp ppf v =
    let s = v.Osinfo.os |> module_name in
    let x = Fmt.str "module %s = struct\n let v = %a\nend" s Osinfo.pp v in
    Fmt.(pf ppf "%s" (format x))
  in
  match Bos.OS.File.read (Fpath.v f) with
  | Ok s ->
      let v = Osinfo.t_of_sexp (Sexp.of_string s) in
      pp Format.std_formatter v
  | Error (`Msg m) -> failwith m

let () = if Array.length Sys.argv <= 1 then write () else read Sys.argv.(2)
