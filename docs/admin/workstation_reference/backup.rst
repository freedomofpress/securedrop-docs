Backup and Restore
==================

Qubes OS has a `backup utility <https://www.qubes-os.org/doc/backup-restore/>`_
that allows for backup and restoration of user-specified VMs and templates.

SecureDrop Workstation requires only that you back up instance-specific secrets
and configuration files, although you can optionally back up some additional local
data.

To perform backups, you will need:

 - a `LUKS-encrypted <https://workstation.securedrop.org/en/stable/admin/reference/provisioning_usb.html>`_ 
   USB or LUKS-encrypted external hard drive (of sufficient size,
   if backing up additional local data)
 - a secure place to store backup credentials (such as a password manager
   on your primary laptop)

Backup
------

Preserve files from ``dom0`` and ``sd-gpg``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Preserve configuration files and private key material by copying them into ``dom0``.

In a ``dom0`` terminal opened via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other Tools ▸ Xfce Terminal**:

  .. code-block:: sh

    qvm-run --pass-io sd-gpg 'gpg -a --export-secret-keys' > sd-keys.asc
    sudo mv sd-keys.asc /usr/share/securedrop-workstation-dom0-config/
    cp -r /usr/share/securedrop-workstation-dom0-config ~

If you have made customizations to ``dom0`` (for example, custom RPC policy files):

  .. code-block:: sh

    mkdir ~/etc-qubes && cp -r /etc/qubes ~/etc-qubes
    mkdir ~/etc-qubes-rpc && cp -r /etc/qubes-rpc ~/etc-qubes-rpc

Back up SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::
  Backups contain sensitive data, and must be created and stored just as securely
  as SecureDrop Workstation itself.

  If performing this backup as part of a migration (from one machine to another
  or from one version of Qubes OS to another), we suggest you retain the backup
  only during the migration process, and destroy it after the migration
  is complete. The easiest way to do this is to create a LUKS-encrypted drive,
  follow this guide to create your backup, and then wipe (reformat) or destroy the
  drive after you have successfully restored it onto the new machine, which should
  ideally happen the same day. In all cases, follow your organization's internal
  policies on handling sensitive assets and information.

  If you are looking to back up your own customized components of SecureDrop Workstation
  for long-term storage, we suggest taking that backup separately from the backup
  of SecureDrop Workstation components so that you can avoid proliferating copies of
  sensitive assets.

Before starting your backup, decide whether you want to back up your data from
``sd-app``. If you skip this step, the first time you log in, your submissions
will re-download from your SecureDrop server.

Ensure your storage medium is plugged in, attached to ``sd-devices``,
and unlocked.

Navigate to |qubes_menu| **▸** |qubes_menu_gear| **▸ Qubes Tools ▸ Backup Qubes**, and move all VMs from
"Selected" to "Available" by pressing the ``<<`` button.

To target a VM for backup, highlight it and move it into the "Selected"
column by pressing the ``>`` button. Select:

- ``dom0``
- the ``sd-app`` VM (optional), noting the warning above
- any customized VMs (and their templates) that you may wish to preserve,
  noting the warning above.

You do not need to back up the other ``sd-`` VMs.

Click "Next", and in "Backup destination," specify the VM and directory
corresponding to your storage medium's current mount point.

Set a strong, unique backup passphrase (7-word diceware), and ensure this
passphrase is stored securely outside SecureDrop Workstation.

.. note::
 This passphrase protects sensitive components of your SecureDrop instance,
 including the *Submission Private Key*, and unencrypted submissions (if
 ``sd-app`` is backed up). Ensure it is a very strong password and is
 stored securely.

Uncheck "save backup profile," then proceed with the backup.

Qubes OS recommends verifying the integrity of the backup once the backup
completes, and this should be done on the same machine where the backup was created.
This can be done by using the Restore Backup GUI tool and selecting
"Verify backup integrity, but do not restore the data." For details, see the
`Qubes OS backup documentation <https://www.qubes-os.org/doc/backup-restore/>`_.

.. warning::
  Any files or data not mentioned above and not backed up elsewhere will be destroyed.
  Ensure that any other data on your system (for example, using KeepassXC
  in the ``vault`` VM, or data stored in other VMs) have been backed up and the
  integrity of the backup has been verified before proceeding.

Restore
-------

Reinstall Qubes OS
~~~~~~~~~~~~~~~~~~

To restore SecureDrop Workstation, follow our
:doc:`pre-install tasks </admin/installation/prepare_sdw>` to provision a Qubes OS system complete with
updated base templates.

Rename or delete redundant AppVMs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By default, Qubes OS will create the AppVMs ``personal``, ``work``, ``untrusted``
and ``vault`` as part of the installation process. Rename or delete any
of these newly created AppVMs whose names conflict with the AppVMs you
intend to restore from a backup.

Example: If you wish to restore the ``vault`` VM, rename or delete the existing
``vault`` VM prior to restoring the backup. You can do so in
|qubes_menu| **▸ Apps ▸ vault ▸ Settings** (the VM must not be running).

Restore Backup (SecureDrop Workstation components)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug in your backup medium and unlock it as during the backup. By default
on a new system, your peripheral devices will be managed by a VM called
``sys-usb``.

Navigate to |qubes_menu| **▸** |qubes_menu_gear| **▸ Qubes Tools ▸ Restore Backup**,
and enter the location of the backup file. You do not need to adjust the default
Restore options, unless you have made customizations to the backup. Enter the
decryption/verification passphrase, and proceed to restoring the available
qubes (which should include ``dom0`` and possibly ``sd-app``).

We suggest restoring only those VMs, provisioning SecureDrop Workstation, and then
restoring any customized VMs you may have had once that process is complete. This way
SecureDrop Workstation is provisioned on a clean system and can implement the security
measures it requires before any additional VMs are configured.

.. note::
  When migrating to a newer version of Qubes OS (for example, Qubes 4.1 to Qubes 4.2),
  you may notice that the original templates for certain VMs are not present on your
  new machine. For the purposes of this guide (optional ``sd-app`` backup),
  this is not a problem. Allow the VM to be restored with the default template
  suggested by the operating system (the current Fedora base template). **Do not start
  the VM.** Continue through the reinstallation process. The correct template will be
  configured as you follow the rest of these instructions.

  If you are restoring your own customized VMs and templates, you will need to take
  additional steps. You may decide to create new templates for your custom VMs and
  provision them with the necessary applications/customizations (recommended), or
  you may upgrade your existing templates following the upstream documentation
  (`Fedora templates <https://www.qubes-os.org/doc/templates/fedora/#upgrading>`_,
  `Debian templates <https://www.qubes-os.org/doc/templates/debian/#upgrading>`_),
  then upgrade their package repositories to the Qubes 4.2 repositories using:

  .. code-block:: sh

    sudo qubes-dom0-update -y qubes-dist-upgrade
    qubes-dist-upgrade --template-standalone --upgrade
 
  More information can be
  found in the `upstream documentation <https://www.qubes-os.org/doc/upgrade/4.2/#clean-installation>`_.
  Contact Support with any questions.

Reinstall SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you do not already have a ``work`` VM, create it with default networking settings:

  .. code-block:: sh

    qvm-create -l blue work

Then, :ref:`download and verify <download_rpm>` the SecureDrop Workstation
.rpm to the ``work`` VM and copy it to ``dom0``.

Once you have a valid .rpm file in ``dom0``, install the .rpm by running:

  .. code-block:: sh

    sudo dnf install securedrop-workstation.rpm

Retrieve the previous SecureDrop Workstation configuration from the backup folder on ``dom0``.
From the ``dom0`` home directory:

  .. code-block:: sh

    ls -d */*/* | grep home-restore

  You should see a directory called ``home-restore-$YYYY-MM-DD-HHMMSS/dom0-home/$USERNAME``.
  We will call this ``$RESTORE_DIR`` in the instructions below.

  .. code-block:: sh

    sudo cp ~/$RESTORE_DIR/securedrop-workstation-dom0-config/{sd-journalist.sec,config.json,sd-keys.asc} /usr/share/securedrop-workstation-dom0-config/

Optionally, inspect each file before proceeding. The first
file should be an ASCII-armored GPG private key file. The second file should
follow the format of the `example configuration file <https://raw.githubusercontent.com/freedomofpress/securedrop-workstation/main/files/config.json.example>`_,
with values for its fields (e.g., ``hostname``, ``submission_key_fpr``) specific to
your configuration. The file may be formatted in a single line without whitespace.
The third file is a backup of key material from ``sd-gpg`` and will be moved into
that VM when you have reprovisioned the system.

Verify that the configuration is valid:

  .. code-block:: sh

    sdw-admin --validate

If the above command prints ``OK``, the configuration is valid.

Reinstall SecureDrop Workstation:

  .. code-block:: sh

    sdw-admin --apply

Restore additional keys to ``sd-gpg``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In a ``dom0`` terminal:

  .. code-block:: sh

    qvm-copy-to-vm sd-gpg $RESTORE_DIR/securedrop-workstation-dom0-config/sd-keys.asc
    qvm-run sd-gpg 'gpg --import /home/user/QubesIncoming/dom0/sd-keys.asc'


Restore Customized VMs, RPC Policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At this stage, you should have a functional SecureDrop Workstation. You may restore any additional
customizations or additional VMs, being mindful that you are responsible for the security
implications of customizing this system.

Customizations in ``dom0`` must be restored manually, meaning that any RPC policies you have added
will need to be moved into place from the ``$RESTORE_DIR``.

Once you are finished with the ``$RESTORE_DIR`` and have verified that your system works (download,
decrypt, sync), you may delete the ``$RESTORE_DIR``.

(Post-Migration Instructions) Destroy backup medium
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wipe (reformat) the LUKS-encrypted storage device that you used to store SecureDrop Workstation
configuration material, overwriting the LUKS header and all data with a new encrypted partition,
or physically destroy the backup medium, to ensure you are not proliferating copies of sensitive data.

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
