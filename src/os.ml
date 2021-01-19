open Types

module Alpine3_12_3 = struct
  let v =
    {
      arch = "x86_64";
      os = "linux";
      os_distribution = "alpine";
      os_version = "3.12.3";
      os_family = "alpine";
    }
end

module Centos8 = struct
  let v =
    {
      arch = "x86_64";
      os = "linux";
      os_distribution = "centos";
      os_version = "8";
      os_family = "rhel";
    }
end

module Debian10 = struct
  let v =
    {
      arch = "x86_64";
      os = "linux";
      os_distribution = "debian";
      os_version = "10";
      os_family = "debian";
    }
end

module Fedora32 = struct
  let v =
    {
      arch = "x86_64";
      os = "linux";
      os_distribution = "fedora";
      os_version = "32";
      os_family = "fedora";
    }
end

module Homebrew10_15_7 = struct
  let v =
    {
      arch = "x86_64";
      os = "macos";
      os_distribution = "homebrew";
      os_version = "10.15.7";
      os_family = "homebrew";
    }
end

module Ubuntu18_04 = struct
  let v =
    {
      arch = "x86_64";
      os = "linux";
      os_distribution = "ubuntu";
      os_version = "18.04";
      os_family = "debian";
    }
end

module Win3210_0_17763 = struct
  let v =
    {
      arch = "x86_64";
      os = "win32";
      os_distribution = "win32";
      os_version = "10.0.17763";
      os_family = "windows";
    }
end
