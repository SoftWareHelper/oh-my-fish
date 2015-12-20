function omf.cli.theme
  switch (count $argv)
  case 0
    omf.cli.themes.list
  case 1
    omf.theme.set $argv[2]
  case '*'
    echo (omf::err)"Invalid number of arguments"(omf::off) 1^&2
    echo "Usage: $_ "(omf::em)"$argv[1]"(omf::off)" [<theme name>]" 1^&2
    return $OMF_INVALID_ARG
  end
end
