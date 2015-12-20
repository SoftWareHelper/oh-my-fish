function omf.cli.remove -a name
  switch (count $argv)
  case 1
    omf.packages.remove $name;
      and refresh
  case '*'
    echo (omf::err)"Invalid number of arguments"(omf::off) 1^&2
    echo "Usage: omf remove "(omf::em)"<name>"(omf::off) 1^&2
    return $OMF_INVALID_ARG
  end
end
