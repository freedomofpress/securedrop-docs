Install Admin Workstation
=========================

Perform the next steps on the laptop you want to become an Admin Workstation. Some steps will vary depending on whether your Admin Workstation will be on a shared laptop that is also a SecureDrop Workstation, or a dedicated laptop for server administration only. 

If you are going to use a dedicated laptop as the Admin Workstation, make sure that you have already :doc:`installed Qubes OS and the SecureDrop packages</admin/installation/install_qubes>` on the laptop before proceeding. 

.. _install_admin_workstation:

Install Admin Workstation
---------------------------

- These steps should be performed from a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
- Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.
- Finally, in the ``dom0`` terminal, run the command:

  .. code-block:: sh

    securedrop-manage --apply --target admin


.. TODO update command for Admin Workstation

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation and set up of the qubes and utilities needed for the role of an Admin Workstation. 

.. _import_submission_key:

Import Submission Public Key
----------------------------

.. TODO waiting for commands

Earlier, you generated the Submission Key for your SecureDrop Instance. The *public* half of this key needs to be imported to the correct location on the Admin Workstation before.

Moving the Submission Public Key to ``sd-admin`` for a combined laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the ``dom0`` terminal, run the command:

.. code-block:: sh

  securedrop-manage --configure --target admin

Importing the Submission Public Key to ``sd-admin`` from another SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
