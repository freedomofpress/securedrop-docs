Updating Tor
============

Given SecureDrop's significant reliance on Tor via Onion Services, we
test new Tor versions to ensure they don't break SecureDrop before releasing
them to users.

Identifying new releases
------------------------

Announcements for new Tor releases are posted in the `Tor forum
<https://forum.torproject.net/c/news/tor-release-announcement/28>`_.

Our continuous integration automatically checks for new Tor packages every
night and should commit them to the `securedrop-dev-packages-lfs
<https://github.com/freedomofpress/securedrop-dev-packages-lfs>`_ repository.
Within 15 minutes they should be available for download via
``apt-test.freedom.press``.

Testing
-------

Use a staging environment to verify that with the new Tor release, SecureDrop
functions properly as an Onion Service, both the Source Interface and protected
Journalist Interface.

Then install the new Tor release on a production environment. Wait a day so
it goes through the unattended-upgrades cycle, confirming that after the
nightly reboot, Tor is still on the new version and running as expected.

Promoting
---------

To promote a Tor release to production, copy the ``*.deb`` files over to the
`securedrop-debian-packages-lfs <https://github.com/freedomofpress/securedrop-debian-packages-lfs>`_
repository and follow those instructions.
