#!/usr/bin/env bash

cd .. || exit

if [ ! "$(arch)" == "x86_64" ]; then
  printf "\\nAppImage executable can be created only on and for 64-bit Linux distributions.\\n"
  exit 1
fi

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

if [ $mode == "none" ]; then
  printf "\\nappimage-maker --include-resources\\n"
  printf "\\nto pack a PEB-based application or\\n"
  printf "\\nappimage-maker --no-resources\\n"
  printf "\\nto pack only a PEB executable\\n"
  exit 1
fi

if [ ! -e "$(pwd)/peb" ]; then
  cd "$(pwd)/src" || exit

  qmake -qt=qt5
  make

  cd .. || exit
fi

linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"

if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x "$linuxdeployqt"
fi

if [ $mode == "no-resources" ]; then
  rm -rf "$(pwd)/peb.app"
  mkdir "$(pwd)/peb.app"

  cp "$(pwd)/peb" "$(pwd)/peb.app/peb"
  cp "$(pwd)/sdk/appimage/peb.desktop" "$(pwd)/peb.app/peb.desktop"
  cp "$(pwd)/src/resources/icon/camel.png" "$(pwd)/peb.app/app.png"

  mkdir -p "$(pwd)/peb.app/usr/share/metainfo"
  cp "$(pwd)/sdk/appimage/peb.appdata.xml" "$(pwd)/peb.app/usr/share/metainfo/peb.appdata.xml"

  "$(pwd)/$linuxdeployqt" "$(pwd)/peb.app/peb" -qmake='qmake -qt=qt5' -no-translations -appimage

  rm -rf "$(pwd)/peb.app"
fi

if [ $mode == "include-resources" ]; then
  package_desktop_file="$(ls ./resources/appimage/*.desktop)"
  if [ ! -e "$package_desktop_file" ]; then
    printf "\\nPackage .desktop file is missing!\\n"
    exit 1
  fi

  package_name="$(basename "$package_desktop_file" .desktop)"

  rm -rf "$(pwd)/$package_name.app"
  mkdir "$(pwd)/$package_name.app"

  cp -f "$(pwd)/peb" "$(pwd)/$package_name.app/$package_name"
  cp -f "$package_desktop_file" "$(pwd)/$package_name.app/$package_name.desktop"
  cp -r "$(pwd)/resources" "$(pwd)/$package_name.app/resources"

  if [ -e "$(pwd)/resources/app.png" ]; then
    cp -f "$(pwd)/resources/app.png" "$(pwd)/$package_name.app/app.png"
  fi

  if [ -e "$(pwd)/resources/appimage/$package_name.appdata.xml" ]; then
    mkdir -p "$(pwd)/$package_name.app/usr/share/metainfo"
    cp -f "$(pwd)/resources/appimage/$package_name.appdata.xml" "$(pwd)/$package_name.app/usr/share/metainfo/$package_name.appdata.xml"
  fi

  rm -rf "$(pwd)/$package_name.app/resources/appimage"

  relocatable_perl="$(pwd)/resources/app/perl/bin/perl"
  compactor_script="$(pwd)/sdk/compactor.pl"

  if [ -e "$relocatable_perl" ]; then
    printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
    "$relocatable_perl" "$compactor_script" "--AppImage"
  else
    printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
  fi

  "$(pwd)/$linuxdeployqt" "$(pwd)/$package_name.app/$package_name" -qmake='qmake -qt=qt5' -no-translations -appimage

  rm -rf "$(pwd)/$package_name.app"
fi
