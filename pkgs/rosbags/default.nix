{
  lib
, fetchFromGitLab
, buildPythonPackage

  # build-system
, setuptools
, setuptools-scm

  # dependencies
, lz4
, numpy
, ruamel-yaml
, typing-extensions
, zstandard
}:

buildPythonPackage rec {
  pname = "rosbags";
  version = "v0.10.9";

  src = fetchFromGitLab {
    owner = "ternaris";
    repo = "rosbags";
    rev = version;
    hash = "sha256-y5OnvIz7NruFqQwILShZtDVx3SH5CywdWZWWWYlMyeY=";
  };
  
  # do not run tests
  doCheck = false;

  # pyproject format is used.
  pyproject = true;

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    lz4
    numpy
    ruamel-yaml
    typing-extensions
    zstandard
  ];

  meta = with lib; {
    homepage = "https://gitlab.com/ternaris/rosbags";
    description = "Rosbags is the pure python library for everything rosbag";
    license = licenses.asl20;
  };
}
