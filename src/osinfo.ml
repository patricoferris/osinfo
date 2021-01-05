open Sexplib.Conv

type t = {
  arch : string;
  os : string;
  os_distribution : string;
  os_family : string;
  os_version : string;
}
[@@deriving sexp]

let pp ppf v =
  let sep = Fmt.any " =@ " in
  let field ppf value = Fmt.(pf ppf "%a;" (quote string) value) in
  let fields =
    [
      Fmt.field ~sep ~label:Fmt.string "arch" (fun (t : t) -> t.arch) field;
      Fmt.field ~sep ~label:Fmt.string "os" (fun (t : t) -> t.os) field;
      Fmt.field ~sep ~label:Fmt.string "os_distribution"
        (fun (t : t) -> t.os_distribution)
        field;
      Fmt.field ~sep ~label:Fmt.string "os_version"
        (fun (t : t) -> t.os_version)
        field;
      Fmt.field ~sep ~label:Fmt.string "os_family"
        (fun (t : t) -> t.os_family)
        field;
    ]
  in
  let r = Fmt.(braces @@ record fields) in
  Fmt.pf ppf "%a" r v
