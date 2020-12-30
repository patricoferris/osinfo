open Sexplib

let write () =
  let os = Osrelease.OS.v () in
  let arch = Osrelease.Arch.v () in
  let distro = Osrelease.Distro.v () |> Rresult.R.get_ok in
  let v : Osinfo.t = { arch; os; distro } in
  let sexp = Osinfo.sexp_of_t v in
  Sexp.pp Format.std_formatter sexp

let read f =
  let module_name = String.capitalize_ascii in
  let pp ppf v =
    let s = v.Osinfo.os |> Osrelease.OS.to_string |> module_name in
    Format.fprintf ppf "module %s = struct\n let v = %a\nend" s Osinfo.pp v
  in
  match Bos.OS.File.read (Fpath.v f) with
  | Ok s ->
      let v = Osinfo.t_of_sexp (Sexp.of_string s) in
      pp Format.std_formatter v
  | Error (`Msg m) -> failwith m

(* let write_ocaml =  *)

let () = if Array.length Sys.argv <= 1 then write () else read Sys.argv.(2)
