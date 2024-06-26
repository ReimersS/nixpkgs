{ lib
, pythonOlder
, pydantic
, flit-core
, fetchFromGitHub
, buildPythonPackage
}:

buildPythonPackage rec {
  pname = "sigstore-rekor-types";
  version = "0.0.12";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "trailofbits";
    repo = "sigstore-rekor-types";
    rev = "refs/tags/v${version}";
    hash = "sha256-B6u2YbtZtgjYJoWL2DfgP7LL20onNaaTTFbC6JIA4bE=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    pydantic
  ] ++ pydantic.optional-dependencies.email;

  # Module has no tests
  doCheck = false;

  meta = with lib; {
    description = "Python models for Rekor's API types";
    homepage = "https://github.com/trailofbits/sigstore-rekor-types";
    changelog = "https://github.com/trailofbits/sigstore-rekor-types/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
