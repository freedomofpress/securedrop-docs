Generate the Submission Key
=============================

When a Source sends a message or file via SecureDrop, the :ref:`Application Server<glossary_application_server>` encrypts it with your instance's :ref:`Submission Key<glossary_submission_key>`. The private part of this key is stored in an isolated `sd-gpg` qube on the Journalist Workstation. Messages and files sent through SecureDrop can only be decrypted on a Journalist Workstation using this private key.

The Submission Key for your SecureDrop is only generated once. Then the public and private parts of this key will be copied to their respective locations. 

If you have opted to perform your initial installation with *two* laptops (distinct Admin and Journalist Workstations, rather than a combined laptop for both) then perform these steps on the laptop that will become the *Journalist Workstation*.

Generate the Submission Key
---------------------------
Generate the Submission Key by running the following command in a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), replacing ``<Org Name>`` with your organization's name:

.. code-block:: sh

    securedrop-generate-submission-key "<Org Name>"

