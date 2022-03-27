{ lib, stdenv, fetchurl, ocaml, findlib, ocamlbuild, cmdliner , topkg, uchar }:
let
  pname = "uutf";
in

stdenv.mkDerivation rec {
  name = "ocaml${ocaml.version}-${pname}-${version}";
  version = "1.0.3";

  src = fetchurl {
    url = "https://erratique.ch/software/${pname}/releases/${pname}${version}.tbz";
    sha256 = "sha256-h3KlYT0ecCmM4U3zMkGjaF8h5O9r20zwP+mF+x7KBWg=";
  };

  nativeBuildInputs = [ ocaml ocamlbuild findlib topkg ];
  buildInputs = [ topkg cmdliner ];
  propagatedBuildInputs = [ uchar ];

  strictDeps = true;

  inherit (topkg) buildPhase installPhase;

  meta = with lib; {
    description = "Non-blocking streaming Unicode codec for OCaml";
    homepage = "https://erratique.ch/software/uutf";
    platforms = ocaml.meta.platforms or [];
    license = licenses.bsd3;
    maintainers = [ maintainers.vbgl ];
  };
}
