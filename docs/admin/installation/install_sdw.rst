Install SecureDrop Workstation
==============================

Perform the next steps on the laptop you want to become a SecureDrop Workstation. Some steps will vary depending on whether your SecureDrop Workstation will be on a shared laptop that is also an Admin Workstation, or a dedicated laptop for Journalists only.

If you are going to use a dedicated laptop as the SecureDrop Workstation, make sure that you have already :doc:`installed Qubes OS and the SecureDrop packages</admin/installation/install_qubes>` on the laptop before proceeding. 

Import onion service file from Admin Workstation
-------------------------------------------------

When installing the SecureDrop servers from an Admin Workstation, the onion addresses of your SecureDrop and the associated :ref:`onion service<glossary_onion_service>` authentication token were created. You need to import the file containing these credentials onto the SecureDrop Workstation.

Moving onion service file to ``dom0`` within a shared laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Importing onion services file from an Admin Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Export onion service file from an Admin Workstation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Import onion service file onto the SecureDrop Workstation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install SecureDrop Workstation
------------------------------

- These steps should be performed from a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
- Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.
- Finally, in the ``dom0`` terminal, run the command:

  .. code-block:: sh

    securedrop-manage --apply inbox


.. TODO update command for SecureDrop Workstation

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation of SecureDrop Inbox and it's associated qubes and configuration.

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 