.. _virtualizing_tails:

Virtual Environments: Admin Workstation
=======================================

SecureDrop uses Tails for the *Admin Workstation* environment. In order to
perform a fully virtualized production install, you will need to first set up
Tails in a virtual machine.

.. note:: For the instructions that follow, you need to download the most
          recent Tails ISO from the `Tails`_ website.

.. _`Tails`: https://tails.boum.org

Only libvirt-based virtualization, on a Linux host, is supported.

Linux
-----

For the Linux instructions, you will use KVM/libvirt to create a Tails VM that
you can use to install SecureDrop on ``app-prod`` and ``mon-prod``.

Create a VM using virt-manager
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Follow the Tails virt-manager instructions for
`running Tails from a USB image <https://tails.boum.org/doc/advanced_topics/virtualization/virt-manager/index.en.html#index4h1>`__.
Then proceed with booting to the USB drive, and `configure Persistent Storage <https://tails.boum.org/doc/first_steps/persistence/index.en.html>`__.

We recommend cloning the SecureDrop repository into the persistent volume for
testing and development, instead of attempting to mount a folder from the host
operating system.
