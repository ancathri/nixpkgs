{ lib
, olefile
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, cryptography
, pytestCheckHook
, pythonOlder
, setuptools
}:

buildPythonPackage rec {
  pname = "msoffcrypto-tool";
  version = "5.2.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "nolze";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-9qhTGf4IE8PtTfshnqu2fcctznA+2bWH4jz0dmKtoOo=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    cryptography
    olefile
    setuptools
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # Test fails with AssertionError
    "test_cli"
  ];

  pythonImportsCheck = [
    "msoffcrypto"
  ];

  meta = with lib; {
    description = "Python tool and library for decrypting MS Office files with passwords or other keys";
    homepage = "https://github.com/nolze/msoffcrypto-tool";
    changelog = "https://github.com/nolze/msoffcrypto-tool/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
