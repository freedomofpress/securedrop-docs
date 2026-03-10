Apply Configuration to Primary SecureDrop Workstation
=====================================================

Install and Configure the SecureDrop App
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With the servers installed and configured, the final step is to install the SecureDrop Workstation App on the primary SecureDrop Workstation and fully configure the machine.

- These steps should be performed from a ``dom0`` terminal. **Start a dom0 terminal** via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other Tools ▸ Xfce Terminal**.

- Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.

- Finally, in the ``dom0`` terminal, run the command:

  .. code-block:: sh

    sdw-admin --apply

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple VMs and installs supporting packages. When the command finishes, reboot the machine to complete the installation. Your SecureDrop Workstation is finally ready to use!

Test the Workstation
~~~~~~~~~~~~~~~~~~~~

The preflight updater will start automatically after logging into the system. Please follow the preflight updater's instructions. 

  .. note::

    If you close the SecureDrop Client during your session, you can launch it again using the SecureDrop icon on the desktop. 

Once the update check is complete, the SecureDrop Client will launch. Log in using an existing journalist account and verify that sources are listed and submissions can be downloaded, decrypted, and viewed.

.. _Password Management Section:

Enable password copy and paste
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you use KeePassXC in the ``vault`` VM to manage login credentials, you can enable the user to copy passwords to the SecureDrop App using inter-VM copy and paste. While this is relatively safe, we recommend reviewing the section :doc:`Managing Clipboard Access <../workstation_reference/managing_clipboard>` of this guide, which goes into further detail on the security considerations for inter-VM copy and paste.

The password manager runs in the networkless ``vault`` VM, and the SecureDrop App runs in the ``sd-app`` VM. To permit this one-directional clipboard use, issue the following command in ``dom0``:

.. code-block:: sh

   qvm-tags vault add sd-send-app-clipboard

Confirm that the tag was correctly applied using the ``ls`` subcommand:

.. code-block:: sh

   qvm-tags vault ls

To revoke this configuration change later or correct a typo, you can use the ``del`` subcommand, e.g.:

.. code-block:: sh

   qvm-tags vault del sd-send-app-clipboard
   
Troubleshooting ``sdw-admin``
=============================

"Failed to return clean data"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An error similar to the following may be displayed during an installation or update:

.. code-block:: none

  sd-log:
        ----------
        _error:
            Failed to return clean data
        retcode:
            None
        stderr:
        stdout:
            deploy

This is a transient error that may affect any of the SecureDrop Workstation VMs. To clear it, run the installation command or update again.

"Temporary failure resolving"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Transient network issues may cause an installation to fail. To work around this, verify that you have a working Internet connection, and re-run the ``sdw-admin --apply`` command.

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 