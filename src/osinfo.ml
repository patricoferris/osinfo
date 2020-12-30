type t = {
  arch : Osrelease.Arch.t;
  os : Osrelease.OS.t;
  distro : Osrelease.Distro.t;
}
[@@deriving sexp]

let pp ppf v =
  Format.fprintf ppf {|{ arch = "%a"; os = "%a"; distro = "%a" }|}
    Osrelease.Arch.pp v.arch Osrelease.OS.pp v.os Osrelease.Distro.pp v.distro
