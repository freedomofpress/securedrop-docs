Reviewing and exporting logs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SecureDrop Workstation aggregates system logs from all its VMs in the ``sd-log`` VM, in the folder ``~/QubesIncomingLogs``, with one subfolder for each VM. You can inspect these logs directly in the ``sd-log`` VM, or you can copy them to another VM, e.g., for purposes of sharing logs with the SecureDrop development team.

Please note that while the logs do not include original filenames or message contents, they do contain sensitive information, e.g.:

- timing and usage information related to SecureDrop access
- the two-word designation for a given source
- metadata about submissions and replies
- error messages that disclose further details

For this reason, the ``sd-log`` VM is networkless, and you cannot copy files from ``sd-log`` to other VMs by default.

If you want to selectively enable copying logs to a single VM, you can use tags, similar to the method used for :doc:`managing clipboard access <managing_clipboard>`. You can add and remove the permission just before each copying operation; the change will take effect immediately.

.. important::

   Before copying logs to a networked VM, inspect them for sensitive information, and redact them as warranted.

To enable copying logs to a target VM, you can use a command like the following in ``dom0``, substituting ``<VM name>`` with the name of the target VM (e.g., ``work``):

.. code-block:: sh

   qvm-tags <VM name> add sd-receive-logs

Verify that the tag was successfully applied using the ``ls`` subcommand:

.. code-block:: sh

   qvm-tags <VM name> ls

To remove the permission, use this command in ``dom0``:

.. code-block:: sh

   qvm-tags <VM name> del sd-receive-logs

With the permission in effect, you can use the command ``qvm-copy`` in a terminal in ``sd-log`` to copy individual files to the target VM. For example, to copy a file ``syslog-redacted.log``, you would use this command:

.. code-block:: sh

   qvm-copy syslog-redacted.log

A graphical prompt will permit you to select any target VM that has the ``sd-receive-logs`` tag. Once successfully copied, the file can be found in the directory ``~/QubesIncoming/sd-log`` in the target VM. See the `Qubes OS documentation on copying files <https://www.qubes-os.org/doc/copying-files/>`__ for more information.

To review current copy permissions, you can use ``qvm-ls`` to print out a list of VMs that can receive files from ``sd-log``:

.. code-block:: sh

   qvm-ls --tags sd-receive-logs
