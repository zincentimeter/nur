{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, onnxruntime
, openssl
}:

rustPlatform.buildRustPackage {
  pname = "shtech-net-loginer";
  version = "2025-04-22";
  src = fetchFromGitHub {
    owner = "ShanghaitechGeekPie";
    repo = "net-loginer";
    rev = "fbceba59397d612f570e3b570397c12eb72e4a99";
    hash = "sha256-JpdWizks8HPl3j17s75XTGjQMupQWtQ1zc7s21W93wg=";
  };

  # useFetchCargoVendor = true;
  cargoHash = "sha256-jxY/p7EgCj0aOvj0zBxGTEsXCX+lWnrrAx8IZF08rfA=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl onnxruntime ];

  meta = {
    description = "适用于新验证系统的上海科技大学网络自动验证登录器";
    homepage = "https://github.com/ShanghaitechGeekPie/net-loginer";
    license = lib.licenses.mit;
  };
}
