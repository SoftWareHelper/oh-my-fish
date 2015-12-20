function omf.cli.themes.list
  set -l current (cat $OMF_CONFIG/theme)

  test (uname) != "Darwin";
    and set regex "\b($current)\b";
    or set -l regex "[[:<:]]($current)[[:>:]]"

  omf.packages.list --database --theme \
    | column | sed -E "s/$regex/"(omf::em)"\1"(omf::off)"/"

  omf::off
end
