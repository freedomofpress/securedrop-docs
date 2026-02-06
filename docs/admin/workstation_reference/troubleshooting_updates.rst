Troubleshooting system updates
==============================

After you log into Qubes, the SecureDrop Workstation
preflight updater will prompt you to check for available
system updates at least once per day.

If updates fail for any reason, the preflight updater will
not launch the SecureDrop App until the
underlying issue has been resolved. This is to ensure
that the system is in a secure state before you
interact with SecureDrop.

.. figure:: images/preflight_update_failed.png
   :alt: A screenshot of the preflight update window,
         displaying a failed update error message. The
         title reads "Security updates failed", and the
         message instructs the user to contact the administrator
         to correct the error. The SecureDrop App cannot
         be started until the error is corrected.

   The error displayed when the preflight updater
   does not successfully complete the update.

This guide offers troubleshooting steps for common
update issues.

Step 1: Locate the updater log
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The preflight updater runs in the ``dom0`` domain. It
writes its log to ``~/.securedrop_updater/logs/updater.log``.
Log files are rotated hourly; if you have started the updater
again since the error occurred, you may need to check the
previous log file.

In order to examine the most recent log file:

1. Open a terminal in ``dom0`` via |qubes_menu| **▸ Gear Icon (left-hand side) ▸ Other Tools ▸ Xfce Terminal**.

2. Change to the ``~/.securedrop_updater/logs/`` directory:

   ``cd ~/.securedrop_updater/logs/``

3. Display the most recent log file:

   ``cat updater.log``

In order to locate a previous log file in the same directory:

1. Locate the most recently modified log file.

   ``ls -t  updater.log* | head -n 2``

2. Display the file that ends with a date and time stamp, e.g.:

   ``cat updater.log.2023-01-01_10``

Step 2: Identify the cause(s) of the error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If the updater has run to completion, you should see a result
line in the log file that looks similar to the following:

.. code-block:: none

  2025-02-24 20:12:11,821 - sd.sdw_updater_gui.UpdaterApp:71(upgrade_status)
  INFO: Signal: upgrade_status {
  'dom0': <UpdateStatus.UPDATES_OK: '0'>,
  'apply_dom0': <UpdateStatus.UPDATES_OK: '0'>,
  'fedora-42-xfce': <UpdateStatus.UPDATES_FAILED: '3'>,
  'sd-large-bookworm-template': <UpdateStatus.UPDATES_OK: '0'>,
  'sd-small-bookworm-template': <UpdateStatus.UPDATES_OK: '0'>,
  'recommended_action': <UpdateStatus.UPDATES_FAILED: '3'>}

In this example, the ``fedora-42-xfce`` VM has failed to update.
This is indicated by the text ``<UpdateStatus.UPDATES_FAILED: '3'>``.

It is possible that multiple steps have failed. Make note of any
of the individual steps that have failed, other than ``recommended_action``.

Step 3: Resolve the issue(s)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The resolution path will depend on which step(s) failed.
Note that ``dom0`` and ``apply_dom0`` are separate steps.


``dom0`` update failures
^^^^^^^^^^^^^^^^^^^^^^^^
1. Open a terminal in ``dom0`` via |qubes_menu| **▸ Gear Icon (left-hand side) ▸ Other Tools ▸ Xfce Terminal**.

2. Perform an interactive ``dom0`` update by running the
   following command:

   ``sudo qubes-dom0-update``

3. Follow the prompts to resolve any issues. If you are
   unsure on how to resolve an error, please contact us
   for assistance.

4. Reboot the system. ``dom0`` updates are often
   security-sensitive, and may require a reboot to take
   effect.

Expired SecureDrop Signing Key
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the update fails after running ``sudo qubes-dom0-update`` as described
above, and the terminal console displays the following message:

.. code-block:: sh

   1. Certificiate 188EDD3B7B22E6A3 invalid: certificate is not alive
       because: The primary key is not live
       because: Expired on 2023-07-04T10:52:20Z
   2. Key 188EDD3B7B22E6A3 invalid: key is not alive
       because: The primary key is not live
       because: Expired on 2023-07-04T10:52:20Z
   [...]
   Error: GPG check FAILED

your system is trying to use an old copy of the SecureDrop Release
Signing Key. You can perform the following steps to fetch the updated
key and remove the expired one:

1. **Start a terminal** in the "work" VM via the menu: |qubes_menu| **▸ Apps ▸ work ▸ Xfce Terminal**

2. **Download the key:**

   *Run command:*

   .. code-block::

         gpg --keyserver hkps://keys.openpgp.org --recv-key "2359 E653 8C06 13E6 5295 5E6C 188E DD3B 7B22 E6A3"

   *Expected output:*

   .. code-block::

      gpg: key 188EDD3B7B22E6A3: public key "SecureDrop Release Signing Key <securedrop-release-key-2021@freedom.press>" imported
      gpg: Total number processed: 1
      gpg: imported: 1

3. **Verify the expiry is 2027-05-24:**

   *Run command:*

   .. code-block::

      gpg -k securedrop

   *Expected output:*

   .. code-block::

      pub   rsa4096 2021-05-10 [SC] [expires: 2027-05-24]
         2359E6538C0613E652955E6C188EDD3B7B22E6A3
      uid           [ unknown] SecureDrop Release Signing Key <securedrop-release-key-2021@freedom.press>
      sub   rsa4096 2021-05-10 [E] [expires: 2027-05-24]

4. **Export the downloaded key:**

   *Run command:*

   .. code-block::

      gpg --armor --export "2359 E653 8C06 13E6 5295 5E6C 188E DD3B 7B22 E6A3" > securedrop-release-key.pub

   *No output expected.*

5. **Print the exported key's checksum:**

   *Run command:*

   .. code-block::

      sha256sum securedrop-release-key.pub

   *Expected output:*

   .. code-block::

      fedef93de425668541545373952b5f92bac4ac1f1253fe5b64c2be2fc941073b securedrop-release-key.pub

6. **Start a dom0 terminal** via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other Tools ▸ Xfce Terminal**.

   The remaining commands will all be executed in this dom0 terminal.

7. **Copy the key into dom0:**

   *Run command:*

   .. code-block::

      qvm-run --pass-io work cat securedrop-release-key.pub > /tmp/securedrop-release-key.pub

   *No output expected.*

8. **Verify the key checksum matches:**

   *Run command:*

   .. code-block::

       sha256sum /tmp/securedrop-release-key.pub

   *Expected output:*

   .. code-block::

      fedef93de425668541545373952b5f92bac4ac1f1253fe5b64c2be2fc941073b /tmp/securedrop-release-key.pub

9. **Copy the key into place:**

   *Run command:*

   .. code-block::

      sudo cp /tmp/securedrop-release-key.pub /etc/pki/rpm-gpg/RPM-GPG-KEY-securedrop-workstation

   *No output expected.*

10. **Delete the old key from RPM:**

   *Run command:*

   .. code-block::

      sudo rpm -e gpg-pubkey-7b22e6a3-609966ad


   *No output expected.*

11. **Import the new key into RPM:**

   *Run command:*

   .. code-block::

      sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-securedrop-workstation

   *No output expected.*


12. **Verify the expiry is 2027-05-24:**

   *Run command:*

   .. code-block::

      gpg --show-keys /etc/pki/rpm-gpg/RPM-GPG-KEY-securedrop-workstation

   *Expected output:*

   .. code-block::

      pub   rsa4096 2021-05-10 [SC] [expires: 2027-05-24]
         2359E6538C0613E652955E6C188EDD3B7B22E6A3
      uid           [ unknown] SecureDrop Release Signing Key <securedrop-release-key-2021@freedom.press>
      sub   rsa4096 2021-05-10 [E] [expires: 2027-05-24]


``sd-*-template`` update failures
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Click the Qubes menu and open a terminal in the impacted
   template. For example, if ``sd-small-bookworm-template`` failed to
   update, select its entry in the Qubes menu and click
   **Terminal**.

2. Perform an interactive template update by running the
   the following commands:

   ``sudo apt update``

   ``sudo apt upgrade``

  The SecureDrop and Whonix templates are based on Debian
  GNU/Linux. The ``apt update`` comand will ensure the package
  index is up-to-date, and the ``apt upgrade`` comand will
  apply updates.

3. Follow the prompts to resolve any issues. If you are
   unsure on how to resolve an error, please contact us
   for assistance.

``fedora-42-xfce`` update failures
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Launch the Qubes GUI Updater from the top righthand
   tray icon. Ensure the ``fedora-42-xfce`` template is
   selected.

2. Run the updater, observing the output in the
   updater dialog.

3. If the update is not successful, contact Support
   and provide the output you see in the dialog.

``apply_dom0`` update failures
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``apply_dom0`` step applies any necessary configuration
changes to the SecureDrop Workstation. If this step fails,
this may indicate a misconfiguration, or it could be a result
of download failures during the operation.

We recommend first re-running the updater by double-clicking
the SecureDrop desktop icon. This may resolve transient network
issues.

If this does not resolve the issue:

1. Locate the ``updater-detail.log`` file in the same directory
   as the ``updater.log`` file. This file contains more detailed
   information about the ``apply_dom0`` step.

   Like the ``updater.log`` file, this file is rotated hourly.

2. Copy this file to a networked VM by using the ``qvm-copy-to-vm``
   command. For example, to copy the file to the ``work`` VM:

   ``qvm-copy-to-vm work ~/.securedrop_updater/logs/updater-detail.log``

3. The file can now be found in ``~/QubesIncoming/dom0/`` in the
   ``work`` VM.

   Send us the file through a secure channel, such as via Signal.
   We will provide further instructions.

Step 4: Restart the updater
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Click the SecureDrop desktop icon to restart the updater.
If all issues have been resolved, the updater should run to
completion and display a success message. If the issue
persists, please contact us for assistance.

.. |blue_qube| image:: ../../images/blue_qube.png
   :alt: Qubes Domains menu
.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
