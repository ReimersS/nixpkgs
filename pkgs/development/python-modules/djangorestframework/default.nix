{ lib
, buildPythonPackage
, fetchFromGitHub
, coreapi
, django
, django-guardian
, pythonOlder
, pytest-django
, pytestCheckHook
, pytz
, pyyaml
, uritemplate
}:

buildPythonPackage rec {
  pname = "djangorestframework";
  version = "3.14.0";
  format = "setuptools";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "encode";
    repo = "django-rest-framework";
    rev = version;
    hash = "sha256-Fnj0n3NS3SetOlwSmGkLE979vNJnYE6i6xwVBslpNz4=";
  };

  propagatedBuildInputs = [
    django
    pytz
  ];

  nativeCheckInputs = [
    pytest-django
    pytestCheckHook

    # optional tests
    coreapi
    django-guardian
    pyyaml
    uritemplate
  ];

  pytestFlagsArray = [
    # ytest.PytestRemovedIn8Warning: Support for nose tests is deprecated and will be removed in a future release.
    "-W" "ignore::pytest.PytestRemovedIn8Warning"
  ];

  pythonImportsCheck = [ "rest_framework" ];

  meta = with lib; {
    description = "Web APIs for Django, made easy";
    homepage = "https://www.django-rest-framework.org/";
    maintainers = with maintainers; [ desiderius ];
    license = licenses.bsd2;
  };
}
