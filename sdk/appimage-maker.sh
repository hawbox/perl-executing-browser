#!/usr/bin/env bash

cd .. || exit

# Architecture check:
if [ ! "$(arch)" == "x86_64" ]; then
  printf "\\nAppImage executable can be created only on and for 64-bit Linux distributions.\\n"
  exit 1
fi

# Script mode is detected from command-line arguments:
mode="none"

for i in "$@"
  do
  case $i in
    --include-resources)
      mode="include-resources"
    ;;
  esac

  case $i in
    --no-resources)
      mode="no-resources"
    ;;
  esac
done

# Help:
if [ $mode == "none" ]; then
  printf "appimage-maker --include-resources\\n"
  printf " to pack a PEB-based application or\\n"
  printf "appimage-maker --no-resources\\n"
  printf " to pack only a PEB executable\\n"
  exit 1
fi

# PEB binary is always compiled from sources:
cd "$(pwd)/src" || exit

rm -rf tmp
rm -f .qmake.stash
rm -f Makefile

qmake -qt=qt5
make

cd .. || exit

# If no 'linuxdeployqt' is found, it is downloaded from the web:
linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"

if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x "$linuxdeployqt"
fi

# Pack PEB without the 'resources' folder:
if [ $mode == "no-resources" ]; then
  # Temporary directory for the creation of the AppImage:
  rm -rf "$(pwd)/peb.app"
  mkdir "$(pwd)/peb.app"

  # Main executable:
  cp "$(pwd)/peb" "$(pwd)/peb.app/peb"

  # Desktop file:
  cp "$(pwd)/sdk/appimage/peb.desktop" "$(pwd)/peb.app/peb.desktop"

  # AppImage icon:
  cp "$(pwd)/src/resources/icon/camel.png" "$(pwd)/peb.app/app.png"

  # AppImage metadata file:
  mkdir -p "$(pwd)/peb.app/usr/share/metainfo"
  cp "$(pwd)/sdk/appimage/peb.appdata.xml" "$(pwd)/peb.app/usr/share/metainfo/peb.appdata.xml"

  # Documentation:
  cp -r "$(pwd)/doc" "$(pwd)/peb.app/doc"
  cp "$(pwd)/CREDITS.md" "$(pwd)/peb.app/CREDITS.md"
  cp "$(pwd)/LICENSE.md" "$(pwd)/peb.app/LICENSE.md"
  cp "$(pwd)/README.md" "$(pwd)/peb.app/README.md"

  # Version:
  export VERSION="1.0.0"

  # AppImage creation:
  "$(pwd)/$linuxdeployqt" "--appimage-extract"
  "$(pwd)/squashfs-root/AppRun" "$(pwd)/peb.app/peb" -qmake='qmake -qt=qt5' -no-translations -appimage

  # Removal of the temporary directories:
  rm -rf "$(pwd)/peb.app"
  rm -rf "$(pwd)/squashfs-root"
fi

# Pack PEB and include the 'resources' folder in the resulting AppImage:
if [ $mode == "include-resources" ]; then
  # AppImage desktop file is mandatory:
  package_desktop_file="$(ls ./resources/app/appimage/*.desktop)"
  if [ ! -e "$package_desktop_file" ]; then
    printf "\\nPackage .desktop file is missing!\\n"
    exit 1
  fi

  # AppImage name:
  appimage_name="$(basename "$package_desktop_file" .desktop)"

  # Temporary directory for the creation of the AppImage:
  rm -rf "$(pwd)/$appimage_name.app"
  mkdir "$(pwd)/$appimage_name.app"

  # Main executable:
  cp -f "$(pwd)/peb" "$(pwd)/$appimage_name.app/$appimage_name"

  # Desktop file:
  cp -f "$package_desktop_file" "$(pwd)/$appimage_name.app/$appimage_name.desktop"

  # AppImage icon:
  if [ -e "$(pwd)/resources/app.png" ]; then
    cp -f "$(pwd)/resources/app.png" "$(pwd)/$appimage_name.app/app.png"
  fi

  # AppImage metadata file:
  if [ -e "$(pwd)/resources/app/appimage/$appimage_name.appdata.xml" ]; then
    mkdir -p "$(pwd)/$appimage_name.app/usr/share/metainfo"
    cp -f "$(pwd)/resources/app/appimage/$appimage_name.appdata.xml" "$(pwd)/$appimage_name.app/usr/share/metainfo/$appimage_name.appdata.xml"
  fi

  # Documentation:
  cp -r "$(pwd)/doc" "$(pwd)/$appimage_name.app/doc"
  cp "$(pwd)/CREDITS.md" "$(pwd)/$appimage_name.app/CREDITS.md"
  cp "$(pwd)/LICENSE.md" "$(pwd)/$appimage_name.app/LICENSE.md"
  cp "$(pwd)/README.md" "$(pwd)/$appimage_name.app/README.md"

  # Resources:
  cp -r "$(pwd)/resources" "$(pwd)/$appimage_name.app/resources"

  # File cleaning:
  rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.desktop"
  rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.appdata.xml"

  # Version:
  export VERSION="1.0.0"

  # AppImage creation:
  "$(pwd)/$linuxdeployqt" "--appimage-extract"
  "$(pwd)/squashfs-root/AppRun" "$(pwd)/$appimage_name.app/$appimage_name" -qmake='qmake -qt=qt5' -no-translations -appimage

  # Removal of the temporary directories:
  rm -rf "$(pwd)/squashfs-root"
  rm -rf "$(pwd)/$appimage_name.app"
fi
