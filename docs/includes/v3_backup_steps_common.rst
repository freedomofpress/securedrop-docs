.. note::  The instructions below assume that you are using the same *Admin Workstation*
   that was used to manage your old instance. If you are using a new *Admin
   Workstation* you will need to copy the directory ``~amnesia/Persistent/securedrop``
   from the old workstation to the new workstation (using a *Transfer Device*)
   before proceeding.

#. If you have not already done so, :ref:`back up the existing installation <backing_up>`. The instructions below assume that the backup has been created and renamed ``sd-backup-old.tar.gz``.

#. Move the existing *Admin Workstation* SecureDrop code out of the way, by
   opening a Terminal via **Applications > System Tools > Terminal** and
   running the command:

   .. code:: sh

      mv ~/Persistent/securedrop ~/Persistent/sd.bak

#. Move the existing *Admin Workstation* SSH configuration out of the way via
   the Terminal, using the commands:

   .. code:: sh

       mv ~/.ssh/config ~/.ssh/config.bak
       mv ~/.ssh/known_hosts ~/.ssh/known_hosts.bak

#. Reinstall SecureDrop  on the *Admin Workstation* using the following Terminal
   commands:

   .. code:: sh

      cd ~/Persistent
      git clone https://github.com/freedomofpress/securedrop

#. Verify that the current release tag was signed with the release signing key:

   .. code:: sh

      cd ~/Persistent/securedrop/
      git fetch --tags
      git tag -v 1.7.1

   The output should include the following two lines:

   .. code:: sh

      gpg:                using RSA key 22245C81E3BAEB4138B36061310F561200F4AD77
      gpg: Good signature from "SecureDrop Release Signing Key"


   .. important::
      If you do not see the message above, signature verification has failed
      and you should **not** proceed with the installation. If this happens,
      please contact us at securedrop@freedom.press.


   Verify that each character of the fingerprint matches what is on the
   screen of your workstation. If it does, you can check out the new release:

   .. code:: sh

      git checkout 1.7.1

   .. important::
      If you see the warning ``refname '1.7.1' is ambiguous`` in the
      output, we recommend that you contact us immediately at
      securedrop@freedom.press (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).

#. Copy the old instance's configuration files and backup from ``~/Persistent/sd.bak`` into ``~/Persistent/securedrop`` using the following Terminal commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      export SD_OLD="~/Persistent/sd.bak/install_files/ansible-base"
      export SD_NEW="~/Persistent/securedrop/install_files/ansible-base"
      cp $SD_OLD/group_vars/all/site-specific $SD_NEW/group_vars/all/site-specific
      cp $SD_OLD/tor_v3_keys.json $SD_NEW/tor_v3_keys.json
      cp $SD_OLD/sd-backup-old.tar.gz $SD_NEW/sd-backup-old.tar.gz

   You will also need to copy the old instance's *Submission Public Key*,
   *Ossec Alert Public Key*, and, if configured, the *Journalist Alert Public Key*.
   Assuming that these are named ``SecureDrop.asc``, ``ossec.asc``, and
   ``journalist.asc`` respectively, run the following commands:

   .. code:: sh

      cp $SD_OLD/SecureDrop.asc $SD_NEW/SecureDrop.asc
      cp $SD_OLD/ossec.asc $SD_NEW/ansible-base/ossec.asc
      cp $SD_OLD/journalist.asc $SD_NEW/ansible-base/journalist.asc

#. *(Optional):* If your old instance was configured to provide the *Source
   Interface* via HTTPS, you should also copy across the certificate, certificate
   key, and chain file. Assuming that these are named ``sd.crt``, ``sd.key``, and
   ``ca.crt`` respectively, run the following commands:

   .. code:: sh

      cp $SD_OLD/sd.{crt,key} $SD_NEW/
      cp $SD_OLD/ca.crt $SD_NEW/

#. Install Ubuntu 20.04 on the *Application* and *Monitor Servers*, following
   the :doc:`server setup instructions<servers>` to install with the correct
   settings, test connectivity, and set up SSH keys to allow for
   *Admin Workstation* access.

#. Reinstall SecureDrop on the servers, following the :doc:`installation
   instructions <../install>`. During the configuration stage
   (``./securedrop-admin sdconfig``), the values will be prepopulated based on
   the old instance's configuration. Press **Enter** to accept each value,
   except when you are asked if you want to enable v2 onion services - instead,
   type ``no``.

   Proceed through the installation, finishing with
   ``./securedrop-admin tailsconfig``. If SSH-over-Tor is configured, run
   ``ssh app uptime`` and ``ssh mon uptime``  in the Terminal to verify SSH
   connectivity and add the new onion URLs to your ``known_hosts`` file.

#. Restore from the old instance's backup (e.g. ``sd-backup-old.tar.gz``) using
   the Terminal command:

   .. code:: sh

       ./securedrop-admin restore sd-backup-old.tar.gz

   The restore task will proceed for some time, removing v2 services if a v2+v3
   backup was used, and then will fail with the message:

   .. code-block:: none

     ssh_exchange_identification: Connection closed by remote host

   during the ``Wait for Tor to reload`` task. This is expected; the
   *Application Server*'s SSH onion service address was updated to the old
   instance's address during the restore process, leaving it temporarily
   unreachable.

#. Copy the old instance's v3 onion service details into place on the
   *Admin Workstation* and repair SSH access using the Terminal commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      cp $SD_OLD/app-{journalist,ssh}.auth_private $SD_NEW/
      cp $SD_OLD/app-sourcev3-ths $SD_NEW
      ./securedrop-admin tailsconfig

#. :doc:`Test the new instance <test_the_installation>` to verify that the
   web interfaces are available and the servers can be reached via SSH.
