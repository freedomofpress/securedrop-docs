Install Admin Workstation
=========================

This step will configure a Qubes OS laptop to serve as a Admin Workstation. In the last step, you :doc:`generated your Submission Key</admin/installation/generate_submission_key>` on a laptop that will become a SecureDrop Workstation. You should perform this step on the same laptop *only* if you intend to create a combined Admin + SecureDrop Workstation that will be shared by Administrators and Journalists. Otherwise, you should use a second laptop upon which you have only installed :doc:`Qubes OS and the SecureDrop packages</admin/installation/install_qubes>`.

.. _install_admin_workstation:

Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**) and configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.

When ready run the following command in the ``dom0`` terminal:

.. code-block:: sh

  securedrop-manage --apply --target admin


.. TODO update command for Admin Workstation

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation and set up of the qubes and utilities needed for the role of an Admin Workstation. 



