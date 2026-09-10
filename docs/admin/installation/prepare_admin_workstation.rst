Prepare an Admin Workstation
============================

Configure ``sd-admin``
----------------------

.. TODO, run the command to do the salt to provision the sd-admin qube!

Import Submission Key
---------------------

Moving the Submission Public Key to ``sd-admin``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Import email alert keys onto the Admin Workstation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You will also need to import the public keys for the :doc:`email addresses that will receive OSSEC alerts and, optionally, daily journalist alerts</admin/installation/email_alerts>`. Repeat the steps above to import these keys onto the Admin Workstation and copy the files to the same ``~/.confid/securedrop-admin/`` directory in the ``sd-admin`` qube. These will be needed when you :doc:`install SecureDrop on the servers</admin/installation/install_servers>`. 

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 