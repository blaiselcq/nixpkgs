{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pdm-backend,
  python-dateutil,
  pydantic,
  pandas,
}:

buildPythonPackage rec {
  pname = "quiffen";
  version = "3.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "blaiselcq"; # TODO change to upstream
    repo = "quiffen";
    # tag = "v${version}"; # TODO use version
    rev = "update-pydantic-version-requirement";
    hash = "sha256-tSBrlRWECCd6wDqh8JuviZAjyi/X+N9Gk19s+SvwY/w=";
  };

  build-system = [ pdm-backend ];

  dependencies = [ python-dateutil pydantic pandas ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "quiffen"
  ];

  meta = {
    homepage = "https://github.com/isaacharrisholt/quiffen";
    description = "Python package for parsing QIF (Quicken Interchange Format) files";
    longDescription = ''
      The package allows users to both read QIF files and interact with the contents,
      and also to create a QIF structure and then output to either a QIF file,
      a CSV of transaction data or a pandas DataFrame.
    '';
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ blaiselcq ];
  };
}
