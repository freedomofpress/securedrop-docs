Updates over Tor
================

In case of censorship or blocking of the SecureDrop APT repository
(``apt.freedom.press``), which provides automatic updates, Tor can be
configured to provide unrestricted access.

.. note:: This is only meant as a temporary measure. SecureDrop generally
          expects an unfiltered internet connection. If you are facing long-term
          censorship, :ref:`please contact us<Getting Support>` for other options.

Configuring updates over Tor
----------------------------

These steps will need to be applied to both the *Application Server* and the
*Monitor Server*.

As mentioned earlier, this is meant to be a temporary measure.
Notably, running ``securedrop-admin install`` will overwrite these changes.

1. From your *Admin Workstation*, SSH into the *Application Server* or *Monitor Server* using ``ssh app`` or ``ssh mon``.
2. Run ``sudo nano /etc/tor/torrc`` to edit the Tor configuration.
   Replace the first line of ``SocksPort 0`` with ``SocksPort 127.0.0.1:9050`` and save the file.
3. Run ``sudo systemctl reload tor@default`` for the new configuration to take effect.
4. Run ``sudo apt-get install apt-transport-tor --yes``.
5. Run ``sudo nano /etc/apt/sources.list.d/apt_freedom_press.list`` to edit the URL to begin with a "tor+" prefix.
   The new contents should be:

.. code::

    deb [arch=amd64] tor+https://apt.freedom.press noble main

6. Run ``sudo apt update`` and verify there are no error messages. This checks that
   fetching updates works

Disabling updates over Tor
--------------------------

From your *Admin Workstation*, run ``securedrop-admin install``. This will overwrite all the above changes.
