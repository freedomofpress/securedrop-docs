Troubleshooting ``sdw-admin``
=============================

"Failed to return clean data"
-----------------------------

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

This is a transient error that may affect any of the SecureDrop Workstation qubes. To clear it, run the installation command or update again.

"Temporary failure resolving"
-----------------------------

Transient network issues may cause an installation to fail. To work around this, verify that you have a working Internet connection, and re-run the ``sdw-admin --apply`` command.