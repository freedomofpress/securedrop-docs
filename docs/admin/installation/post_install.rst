Post install setup
==================

Enable password copy and paste
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you use KeePassXC in the ``vault`` qube to manage login credentials, you can enable the user to copy passwords to SecureDrop Inbox using inter-qube copy and paste. While this is relatively safe, we recommend reviewing the section :doc:`Managing Clipboard Access </admin/workstation_reference/managing_clipboard>` of this guide, which goes into further detail on the security considerations for inter-qube copy and paste.

The password manager runs in the networkless ``vault`` qube, and the SecureDrop Inbox application runs in the ``sd-app`` qube. To permit this one-directional clipboard use, issue the following command in ``dom0``:

.. code-block:: sh

   qvm-tags vault add sd-send-app-clipboard

Confirm that the tag was correctly applied using the ``ls`` subcommand:

.. code-block:: sh

   qvm-tags vault ls

To revoke this configuration change later or correct a typo, you can use the ``del`` subcommand, e.g.:

.. code-block:: sh

   qvm-tags vault del sd-send-app-clipboard

.. TODO Backups