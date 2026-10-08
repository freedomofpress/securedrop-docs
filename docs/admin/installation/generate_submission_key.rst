Generate the Submission Key
=============================

When a Source sends a message or file via SecureDrop, it is automatically encrypted with the instance's :ref:`Submission Key<glossary_submission_key>`. The private part of this key is stored in an isolated `sd-gpg` qube on the SecureDrop Workstation used by Journalists. Messages and files sent through SecureDrop can only be decrypted on a SecureDrop Workstation using this key.


Your SecureDrop Submission key should be generated on a laptop that will become a SecureDrop Workstation for use by Journalists. You only need to generate the Submission Key once. If you are setting up multiple SecureDrop Workstations, you will securely copy the Submission Private Key from an existing Workstation to the new one. 

Create the Submission Key
-------------------------

If you have just installed Qubes OS on a number of laptops, select the one destined to become a SecureDrop Workstation for Journalists to use. Create the Submission Key on this laptop with the steps below.

#. If not already, boot and log into Qubes OS.
#. Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
#. Run the following command:

.. TODO

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 