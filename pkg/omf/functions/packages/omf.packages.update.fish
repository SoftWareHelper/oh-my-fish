function __omf.packages.update.success
  echo (omf::em)"✔ $argv successfully updated."(omf::off)
  return 0
end

function __omf.packages.update.error
  echo (omf::err)"Could not update $argv."(omf::off) 1^&2
  return 1
end

function omf.packages.update -a name

  if test \( -e $OMF_PATH/themes/$name \) -o \( -e $OMF_CONFIG/themes/$name \)
    set install_type "theme"
    set parent_path "themes"
  else
    set install_type "package"
    set parent_path "pkg"
  end

  for path in {$OMF_PATH,$OMF_CONFIG}/pkg/$name
    not test -e "$path/.git"; and continue

    omf.repo.pull $path; and set return_success

    set -q return_success;
      and omf.bundle.install $path/bundle
  end

  set -q return_success;
    and __omf.packages.update.success $name;
    or __omf.packages.update.error $name
end
