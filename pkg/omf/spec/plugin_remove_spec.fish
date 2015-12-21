function describe_plugin_remove
  function before_all
    set -gx CI WORKAROUND
  end

  function before_each
    rm -rf $OMF_PATH/pkg/omf-test-plugin-* ^/dev/null
    cp $OMF_CONFIG/bundle $OMF_CONFIG/bundle.fish-spec
  end

  function after_each
    rm -rf $OMF_PATH/pkg/omf-test-plugin-* ^/dev/null
    cp $OMF_CONFIG/bundle.fish-spec $OMF_CONFIG/bundle
  end

  function after_all
    rm -rf $OMF_PATH/db/pkg/omf-test-plugin-*
  end

  #function it_returns_an_error_when_called_with_no_arguments
    #set -l output (omf remove 2>&1)
    #assert 1 = $status; or echo $output
  #end

  function it_prints_an_error_message_when_called_with_no_arguments
    set -l output (omf remove 2>&1)
    echo $output | grep -q "Invalid number of arguments"
    assert 0 = $status; or echo $output
  end

  function it_removes_the_plugin_from_the_bundle_file
    omf install (plugin) >/dev/null

    cat $OMF_CONFIG/bundle | grep -q (plugin)
    assert 0 = $status

    omf remove (plugin) >/dev/null

    cat $OMF_CONFIG/bundle | grep -q (plugin)
    assert 1 = $status
  end

  function it_removes_the_plugin_from_the_computer
    omf install (plugin) >/dev/null

    ls $OMF_PATH/pkg/(plugin) >/dev/null
    assert 0 = $status

    omf remove (plugin) >/dev/null

    ls $OMF_PATH/pkg/(plugin) ^/dev/null
    assert 1 = $status
  end

  function it_is_not_permitted_to_remove_omf_plugin
    omf remove omf
    assert 3 = $status
  end

  ### Factories ###

  function plugin
    cp $OMF_PATH/db/pkg/basename-compat $OMF_PATH/db/pkg/omf-test-plugin-valid
    echo 'omf-test-plugin-valid'
  end
end
