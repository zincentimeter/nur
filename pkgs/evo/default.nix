{
  lib
, fetchFromGitHub
, buildPythonPackage

  # build-system
,  hatchling

  # dependencies
, argcomplete
, colorama
, matplotlib
, natsort
, numexpr
, numpy
, pandas
, pillow
, pygments
, pyyaml
, rosbags
, scipy
, seaborn
}:

buildPythonPackage rec {
  pname = "evo";
  version = "v1.31.1";

  src = fetchFromGitHub {
    owner = "MichaelGrupp";
    repo = "evo";
    rev = version;
    hash = "sha256-wmXovC0v/nRylD9lN1h7FntLvV0EVQRz7bFGkpEJQeQ=";
  };

  # do not run tests
  doCheck = false;

  # pyproject format is used.
  pyproject = true;

  build-system = [
    hatchling
  ];

  dependencies = [
    argcomplete
    colorama
    matplotlib
    natsort
    numexpr
    numpy
    pandas
    pillow
    pygments
    pyyaml
    rosbags
    scipy
    seaborn
  ];

  meta = with lib; {
    homepage = "https://github.com/MichaelGrupp/evo";
    description = "Python package for the evaluation of odometry and SLAM";
    license = licenses.gpl3;
  };
}
