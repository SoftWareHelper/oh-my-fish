function __omf.packages.new.mkdir -a name
  set -l name "$argv[1]"
  if test -d "$OMF_CONFIG"
    set name "$OMF_CONFIG/$name"
  else if test -d "$OMF_PATH"
    set name "$OMF_PATH/$name"
  end
  mkdir -p "$name"
  echo $name
end

function omf.packages.new -a option name
  switch $option
    case "p" "pkg" "pack" "packg" "package"
      set option "pkg"
    case "t" "th" "the" "thm" "theme" "themes"
      set option "themes"
    case "*"
      echo (omf::err)"$option is not a valid option."(omf::off) 1^&2
      return $OMF_INVALID_ARG
  end

  if not omf.util_valid_package "$name"
    echo (omf::err)"$name is not a valid package/theme name"(omf::off) 1^&2
    return $OMF_INVALID_ARG
  end

  if set -l dir (__omf.packages.new.mkdir "$option/$name")
    cd $dir

    set -l github (git config github.user)
    test -z "$github"; and set github "{{USER}}"

    set -l user (git config user.name)
    test -z "$user"; and set user "{{USER}}"

    omf.packages.new_from_template "$OMF_PATH/pkg/omf/templates/$option" \
      $github $user $name

    echo (omf::em)"Switched to $dir"(omf::off)

    if test "$option" = themes
      omf.theme.set $name
    end
  else
    echo (omf::err)"\$OMF_CONFIG and/or \$OMF_PATH undefined."(omf::off) 1^&2
    exit $OMF_UNKNOWN_ERR
  end
end
