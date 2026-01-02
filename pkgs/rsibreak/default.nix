{
  mkKdeDerivation,
  fetchFromGitLab,
  lib,
  wrapQtAppsHook,
  cmake,
  extra-cmake-modules,
  kdoctools,
  knotifyconfig,
  kidletime,
  kwindowsystem,
  ktextwidgets,
  kcrash,
  kstatusnotifieritem,
  libkscreen,
  layer-shell-qt,
  kwayland
}:

mkKdeDerivation {
  pname = "rsibreak";
  version = "0.13.0-master";

  # Include Wayland support
  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "gaboo";
    repo = "rsibreak";
    rev = "2dac3949e29775be5f6f3cb94104c0fdd761cd82";
    sha256 = "zGurVguV4F1E2ODM5RgklMZkV9MB+YLBb6Fd5CQMlHo=";
  };

  outputs = [ "out" "dev" ];

  nativeBuildInputs = [
    wrapQtAppsHook
    cmake
    extra-cmake-modules
    kdoctools
  ];

  propagatedBuildInputs = [
    knotifyconfig
    kidletime
    kwindowsystem
    ktextwidgets
    kcrash
    kstatusnotifieritem
    libkscreen
    layer-shell-qt
    kwayland
  ];

  meta = {
    description = "Takes care of your health and regularly breaks your work to avoid repetitive strain injury (RSI)";
    mainProgram = "rsibreak";
    license = lib.licenses.gpl2;
    homepage = "https://www.kde.org/applications/utilities/rsibreak/";
  };
}
