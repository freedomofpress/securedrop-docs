Apply Admin Workstation configuration
=====================================

The SecureDrop installation process uses authenticated :ref:`Onion Services<glossary_onion_service>` as an additional layer of protection for access to the SecureDrop Servers:

#. The Admin Interface, because it provides access to submissions (although they are encrypted to the Submission Private Key), and some metadata about sources and submissions.

And, unless SSH-over-Tor is :doc:`disabled</admin/deployment/ssh_over_local_net>`:

#. SSH on the Application Server
#. SSH on the Monitor Server

In order to access an authenticated Onion Service, you require its private key. 

The ``securedrop-admin`` utility will configure Tor Browser and SSH in ``sd-admin`` to provide this private key automatically, and to set up Qubes Menu shortcuts to access the Admin Interface and open SSH connections to the Application and Monitor Servers.

To perform this configuration open a terminal in ``sd-admin`` (|qubes_menu| **▸** ``sd-admin```` **▸ Xfce Terminal**), and run:

.. code:: sh

    securedrop-admin localconfig
