function omf.bundle.install
  set bundle $OMF_CONFIG/bundle

  if test -f $bundle
    set packages (omf.packages.list --installed)
    set bundle_contents (cat $bundle | sort -u)

    for record in $bundle_contents
      test -n "$record"; or continue

      set type (echo $record | cut -s -d' ' -f1 | sed 's/ //g')
      contains $type theme package; or continue

      set name_or_url (echo $record | cut -s -d' ' -f2- | sed 's/ //g')
      test -n "$name_or_url"; or continue

      echo "basename"
      echo $name_or_url
      echo "$name_or_url"
      set name (basename -a "$name_or_url" | sed 's/\.git//;s/^pkg-//;s/^plugin-//;s/^theme-//')
      echo "after basename"

      if not contains $name $packages
        omf.install $name_or_url;
          and set installed
      end
    end

    sort -u $bundle -o $bundle
  end

  set -q installed
end
