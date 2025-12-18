{ lib
, buildKdePlugin
, fetchFromGitHub
}:

buildKdePlugin rec {
  pname = "shutdown-or-switch";
  kPluginId = "org.kde.plasma.shutdownorswitch";
  version = "1.1.3";
  src = fetchFromGitHub {
    owner = "Davide-sd";
    repo = "shutdown_or_switch";
    rev = "v${version}";
    hash = "sha256-nCSHYBQcw6Ids/+xwqz2vfn8TaLTUNhP86kMUluMWN0";
  };
  meta = {
    description = "Quickly switch between different users and access shutdown options";
    homepage = "https://github.com/Davide-sd/shutdown_or_switch";
    license = lib.licenses.gpl2Plus;
  };
}
