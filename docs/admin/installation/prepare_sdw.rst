Prepare a SecureDrop Workstation
================================

.. _download_rpm:

Install SecureDrop Workstation packages
---------------------------------------

First, you must configure the Qubes-Contrib repo, then download the SecureDrop Workstation packages.

- Make sure that network connection is enabled using the network manager widget in the upper right panel.

- Next, in a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**):

  .. code-block:: sh

    sudo qubes-dom0-update -y qubes-repo-contrib
    sudo qubes-dom0-update --clean -y securedrop-workstation-keyring

- The SecureDrop Release keyring will be installed on your machine. Wait 15 seconds for the key to be imported into the ``rpm`` database. Then:

  .. code-block:: sh

    sudo qubes-dom0-update --clean -y securedrop-workstation-dom0-config
    sudo dnf -y remove qubes-repo-contrib

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
