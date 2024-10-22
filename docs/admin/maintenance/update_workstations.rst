Troubleshooting Workstation Updates
===================================

This section includes some general troubleshooting instructions for common workstation
update issues. For additional, version-specific issues and recommended actions,
please see the relevant admin upgrade guide.

Performing a manual update
~~~~~~~~~~~~~~~~~~~~~~~~~~
Sometimes, when an update doesn't go according to plan, it's necessary to perform a 
manual update and clear the update flag.

If the graphical updater fails and you want to perform a manual update instead,
first delete the graphical updater's temporary flag file, if it exists (the
``.`` before ``securedrop`` is not a typo): ::

  rm ~/Persistent/.securedrop/securedrop_update.flag

This will prevent the graphical updater from attempting to re-apply the failed
update and has no bearing on future updates. You can now perform a manual
update by running the following commands: ::

  cd ~/Persistent/securedrop
  git fetch --tags
  gpg --keyserver hkps://keys.openpgp.org --recv-key \
   "2359 E653 8C06 13E6 5295 5E6C 188E DD3B 7B22 E6A3"
  git tag -v 2.10.1

The output should include the following two lines: ::

    gpg:                using RSA key 2359E6538C0613E652955E6C188EDD3B7B22E6A3
    gpg: Good signature from "SecureDrop Release Signing Key <securedrop-release-key-2021@freedom.press>" [unknown]


Please verify that each character of the fingerprint above matches what is
on the screen of your workstation. A warning that the key is not certified
is normal and expected. If the output includes the lines above, you can check
out the new release: ::

    git checkout 2.10.1

.. important:: If you do see the warning "refname '2.10.1' is ambiguous" in the
  output, we recommend that you contact us immediately at securedrop@freedom.press
  (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).

Finally, run the following commands: ::

  sudo apt update
  ./securedrop-admin setup
  ./securedrop-admin tailsconfig
