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
  { Osinfo.arch; os; os_family; os_distribution; os_version }

let format s =
  let ocamlformat = Bos.Cmd.(v "ocamlformat" % "--impl" % "-") in
  Bos.OS.Cmd.(in_string s |> run_io ocamlformat |> out_string) |> function
  | Ok (t, _) -> t
  | Error (`Msg m) ->
      Format.printf "Failed: %s" m;
      s

let run v =
  let module_name = String.capitalize_ascii in
  let v_to_string v = String.split_on_char '.' v |> String.concat "_" in
  let pp ppf v =
    let s = (v.Osinfo.os |> module_name) ^ v_to_string v.os_version in
    let x = Fmt.str "module %s = struct\n let v = %a\nend" s Osinfo.pp v in
    Fmt.(pf ppf "%s\n" (format x))
  in
  pp Format.std_formatter v

let () = run (write ())
