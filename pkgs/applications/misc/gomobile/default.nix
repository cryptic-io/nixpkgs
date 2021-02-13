{ lib, buildGoModule, fetchFromGitHub, libglvnd, xlibs, openal}:

buildGoModule {
  pname = "gomobile";
  version = "unstable-2020-12-17"; # gomobile doesn't do releases

  src = fetchFromGitHub {
    owner = "golang";
    repo = "mobile";
    rev = "e6ae53a27f4fd7cfa2943f2ae47b96cba8eb01c9";
    sha256 = "03dzis3xkj0abcm4k95w2zd4l9ygn0rhkj56bzxbcpwa7idqhd62";
  };

  vendorSha256 = "1n1338vqkc1n8cy94501n7jn3qbr28q9d9zxnq2b4rxsqjfc9l94";

  CGO_CFLAGS = [
    "-I ${libglvnd.dev}/include"
    "-I ${xlibs.libX11.dev}/include"
    "-I ${xlibs.xorgproto}/include"
    "-I ${openal}/include"
  ];

  CGO_LDFLAGS = [
    "-L ${libglvnd}/lib"
    "-L ${xlibs.libX11}/lib"
    "-L ${openal}/lib"
  ];

  # gomobile's tests don't like being run by nix, just skip the check phase.
  checkPhase = "";

  meta = with lib; {
      description = "Build tools for using Go on mobile platforms.";
      license = licenses.golang;
      homepage = src.meta.homepage;
      maintainers = with maintainers; [ mediocregopher ];
  };
}

