Prepare Admin Workstation
=========================

Perform the next steps on the laptop you want to become an Admin Workstation. Some steps will vary depending on whether your Admin Workstation will be on a shared laptop that is also a SecureDrop Workstation for Journalaists, or a dedicated laptop for server administration only. 

If you are going to use a dedicated laptop as the Admin Workstation, make sure that you have already :doc:`installed Qubes OS and the SecureDrop packages</admin/installation/install_qubes>` on the laptop before proceeding. 

.. _install_configure_securedrop_app:

Install Admin Workstation
---------------------------

- These steps should be performed from a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
- Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.
- Finally, in the ``dom0`` terminal, run the command:

  .. code-block:: sh

    securedrop-manage --apply admin


.. TODO update command for Admin Workstation

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation and set up of the qubes and utilities needed for the role of an Admin Workstation. 

Import Submission Key
---------------------

Earlier, you generated the Submission Key for your SecureDrop Instance. The public half of this key needs to be imported to the correct location on the Admin Workstation before.

Moving the Submission Public Key to ``sd-admin`` for a shared laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you are using the same laptop as your Admin and SecureDrop Workstations, the Submission Public Key you created earlier is now in ``dom0`` at ``/usr/share/securedrop-workstation-dom0-config/sd-public.sec``. To copy it to the ``sd-admin`` qube, open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**) and run the following command:

.. code-block:: sh

    cat /usr/share/securedrop-workstation-dom0-config/sd-public.sec | qvm-run --pass-io sd-admin 'cat > /home/user/.config/securedrop-admin/'

Importing the Submission Public Key from a SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you are using different laptops as Admin and SecureDrop Workstations, you should have created your Submission Key on the SecureDrop Workstation. You will need to copy the Submission Public Key from that laptop to this Admin Workstation. 

.. warning:: While following these steps, it is essential that you only copy the **Public** Key (``sd-public.sec``). Take care to not copy the Private Key (``sd-journalist.sec``) by mistake.

Export Submission Public Key from a SecureDrop Workstation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Insert a USB flash drive. You may use an encrypted drive such as an :ref:`Export Device<glossary_export_device>`, but it is not necessary for transferring the public key. 
#. Open the Qubes Devices menu and find your newly inserted USB flash drive under **USB Storage** at the bottom of the list (indicated by the word **new** in blue).
#. Attach your USB flash drive to a **new disposable qube**.

.. TODO Screenshot

#. Open the file manager in the new running disposable qube from the Qubes Domains menu.

.. TODO Screenshot

#. Select your USB flash drive in the file manager to mount it (and unlock it if it is an encrypted Export Device).

.. TODO Screenshot

#. Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
#. From the ``dom0`` terminal, run the following command where ``dispXXXX`` is replaced with the name of the disposable qube your USB flash drive is mounted in (e.g. ``disp4423``):

.. code-block:: sh

    qvm-copy-to-vm dispXXXX /usr/share/securedrop-workstation-dom0-config/sd-public.sec

#. The Submission Public Key will now be in the disposable qube, in the ``~/QubesIncoming/dom0`` directory. Drag and drop to copy it onto your USB flash drive.

.. TODO Screenshot

#. Use the Qubes Devices menu to detach the USB flash drive and shut down the disposable qube.

.. TODO Screenshot

.. _import_to_admin_workstation:

Import Submission Public Key onto the Admin Workstation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Insert the USB flash drive into the Admin Workstation
#. Open the Qubes Devices menu and find your newly inserted USB flash drive under **USB Storage** at the bottom of the list (indicated by the word **new** in blue).
#. Attach your USB flash drive to a **sd-admin**.

.. TODO Screenshot

#. Open the file manager in ``sd-admin`` (|qubes_menu| **▸** ``sd-admin```` **▸ Thunar File Manager**). 
#. Select your USB flash drive in the file manager to mount it (and unlock it if it is an encrypted Export Device).

.. TODO Screenshot

#. Right click on the ``sd-public.sec`` file and drag and drop to copy to the **Home** directory.

.. TODO Screenshot

#. Open a terminal in ``sd-admin`` (|qubes_menu| **▸** ``sd-admin```` **▸ Xfce Terminal**) and run the following command to move the Submission Public Key:

.. code-block:: sh

    mv ~/sd-public.sec ~/.config/securedrop-admin/


.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
