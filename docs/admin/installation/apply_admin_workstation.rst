Apply Admin Workstation configuration
=====================================

SecureDrop uses authenticated :ref:`Onion Services<glossary_onion_service>` as an additional layer of protection for accessing the :ref:`Admin Interface<glossary_admin_interface>` in Tor Browser and accessing the Application and Monitor servers directly over SSH (unless SSH-over-Tor is :doc:`disabled</admin/reference/ssh_over_local_net>`).

In order to access an authenticated Onion Service, you require its secret key. 

The ``securedrop-admin`` utility will configure Tor Browser and SSH in ``sd-admin`` to provide this secret key automatically, and to set up Qubes Menu shortcuts to access the Admin Interface and open SSH connections to the Application and Monitor Servers.

To perform this configuration open a terminal in ``sd-admin`` (|qubes_menu| **▸** ``sd-admin`` **▸ Xfce Terminal**), and run:

.. code:: sh

    securedrop-admin localconfig
