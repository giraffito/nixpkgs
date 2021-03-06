{ stdenv, fetchurl, pkgconfig, intltool, gtk3, glib, libid3tag, id3lib, taglib
, libvorbis, libogg, flac, itstool, libxml2, gsettings-desktop-schemas
, gnome3, wrapGAppsHook
}:

let
  pname = "easytag";
  version = "2.4.3";
in stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${gnome3.versionBranch version}/${name}.tar.xz";
    sha256 = "1mbxnqrw1fwcgraa1bgik25vdzvf97vma5pzknbwbqq5ly9fwlgw";
  };

  NIX_LDFLAGS = "-lid3tag -lz";

  nativeBuildInputs = [ pkgconfig intltool itstool libxml2 wrapGAppsHook ];
  buildInputs = [
    gtk3 glib libid3tag id3lib taglib libvorbis libogg flac
    gsettings-desktop-schemas gnome3.defaultIconTheme
  ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      versionPolicy = "none";
    };
  };

  meta = with stdenv.lib; {
    description = "View and edit tags for various audio files";
    homepage = https://wiki.gnome.org/Apps/EasyTAG;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ fuuzetsu ];
    platforms = platforms.linux;
  };
}
