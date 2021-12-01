generate_localizations() {
    cat l10n.yaml &>/dev/null && echo "Found localizations config in $path" && flutter gen-l10n
}

# go into the folder provided as first argument
cd $1 || exit

# if the given folder is a dart project, then run tests on the given package and sub-packages
# otherwiser iterate all folders and try to run tests on those packages and their sub-packages
if [ -f "pubspec.yaml" ]
then
    generate_localizations
else
    for d in ./*/ ; do
      echo "Generating localization files on package $d"
      (cd "$d" && generate_localizations);
    done
fi
