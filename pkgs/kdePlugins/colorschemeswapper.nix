{ lib
, buildKdePlugin
, fetchFromGitHub
}:

buildKdePlugin {
  pname = "colorschemeswapper";
  kPluginId = "com.github.heqro.day-night-switcher";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "heqro";
    repo = "colorschemeswapper-plasmoid";
    rev = "8fbf4940d8112ee13e12181312cf3dfde8d2b8e7";
    hash = "sha256-jkpDMLAycbcuO5Z2bgkez6VSg9742rNxqa/WD7jyMUY=";
  };
  meta = {
    description = "Swap your day/night or any other color scheme you want";
    homepage = "https://github.com/heqro/colorschemeswapper-plasmoid";
    license = lib.licenses.gpl3Only;
  };
}
