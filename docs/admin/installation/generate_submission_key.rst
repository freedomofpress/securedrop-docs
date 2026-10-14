Generate the Submission Key
=============================

When a Source sends a message or file via SecureDrop, the App Server encrypts it with the instance's :ref:`Submission Key<glossary_submission_key>`. The private part of this key is stored in an isolated `sd-gpg` qube on the Journalist Workstation. Messages and files sent through SecureDrop can only be decrypted on a Journalist Workstation using this private key.

The Submission Key for your SecureDrop only needs to be generated once. If you have opted to perform your initial installation with *two* laptops (distinct Admin and Journalist Workstations, rather than a combined laptop for both) then perform these steps on the laptop that will become the *Journalist Workstation*.

Generate the Submission Key
---------------------------
Generate the Submission Key with the steps below.

#. If not already, boot and log into Qubes OS.
#. Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
#. Run the following command:

.. TODO
