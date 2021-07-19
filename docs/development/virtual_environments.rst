Virtual Environments: Servers
=============================

SecureDrop is a multi-server system, and  you may need the full server
stack available in order to develop and test some features. To make this easier, 
the project includes a Vagrantfile that can be used to create two predefined 
virtual environments:

* :ref:`Staging <staging_vms>`
* :ref:`Production <production_vms>`

This document explains the purpose of, and how to get started working with, each
one.

.. note:: If you plan to alter the configuration of any of these machines, make sure to
          review the :ref:`config_tests` documentation.

.. _staging_vms:

Staging
-------

A compromise between the development and production environments. This
configuration can be thought of as identical to the production environment, with
a few exceptions:

* The Debian packages are built from your local copy of the code, instead of
  installing the current stable release packages from https://apt.freedom.press.
* The staging environment is configured for direct SSH access so it's
  more ergonomic for developers to interact with the system during debugging.
* The Postfix service is disabled, so OSSEC alerts will not be sent via email.

This is a convenient environment to test how changes work across the full stack.

You should first bring up the VM required for building the app code
Debian packages on the staging machines:

.. code:: sh

   make build-debs
   make staging
   molecule login -s libvirt-staging-focal -h app-staging
   sudo -u www-data bash
   cd /var/www/securedrop
   ./manage.py add-admin

To rebuild the local packages for the app code and update the staging VMs:

.. code:: sh

   make build-debs
   make staging

The Debian packages will be rebuilt from the current state of your
local git repository and then installed on the staging servers.

The web interfaces and SSH are available over Tor. A copy of the the Onion URLs
for *Source* and *Journalist Interfaces*, as well as SSH access, are written to the
Vagrant host's ``install_files/ansible-base`` directory.

To access the *Source Interface* from Tor Browser, use the v3 onion URL from the file 
``install_files/ansible-base/app-sourcev3-ths``.

To use the *Journalist Interface*, you will need to modify Tor Browser's 
configuration to allow access to an authenticated onion service:

- First, add the following line to your Tor Browser's ``torrc`` file, typically
  found at ``tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc``:

  .. code-block:: none

    ClientOnionAuthDir TorBrowser/Data/Tor/onion_auth

- Next, create the ``onion_auth`` directory:

  .. code:: sh

    mkdir tor-browser_en-US/Browser/TorBrowser/Data/Tor/onion_auth
    chmod 0700 tor-browser_en-US/Browser/TorBrowser/Data/Tor/onion_auth

- Finally, copy the file ``install_files/ansible-base/app-journalist.auth_private``
  to the ``onion_auth`` directory and restart Tor Browser. You should now be able 
  to visit the v3 onion address in ``app-journalist.auth_private`` from Tor Browser.


For working on OSSEC monitoring rules with most system hardening active, update
the OSSEC-related configuration in
``install_files/ansible-base/staging.yml`` so you receive the OSSEC
alert emails.

Direct SSH access is available for staging hosts, so you can use
``molecule login -s <scenario> -h app-staging``, where ``<scenario>``
is either ``libvirt-staging-focal`` or ``qubes-staging-focal``, depending
on your environment.

By default, the staging environments are created with an empty submissions database. If you want to set up a staging environment with a preexisting submissions database, you can do so using a SecureDrop backup file as follows:

- Create a directory ``install_files/ansible-base/test-data``.
- Copy the backup file to the directory above.
- Define an environmental variable ``TEST_DATA_FILE`` whose value is the name  of the backup file - for example ``sd-backup.tar.gz`` - and run ``make staging``:
  
  .. code:: sh

    TEST_DATA_FILE="sd-backup.tar.gz" make staging

A staging environment will be created using the submissions and account data from the backup, but ignoring the backup file's Tor configuration data.

.. note:: It is not recommended to use backup data from a live SecureDrop installation in staging, as the backup may contain sensitive information and the staging environment should not be considered secure.


When finished with the Staging environment, run ``molecule destroy -s <scenario>``
to clean up the VMs. If the host machine has been rebooted since the Staging
environment was created, Molecule will fail to find the VM info, as it's stored
in ``/tmp``. If you use libvirt, run ``virt-manager`` and destroy the staging VMs
manually, by right-clicking on the entries and choosing **Destroy**.

.. _production_vms:

Production
----------

This is a production installation with all of the system hardening active, but
virtualized, rather than running on hardware. You will need to
use a virtualized Admin Workstation in order to provision these machines.

.. _libvirt_provider:

Switching to the Vagrant libvirt provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Make sure you've already installed Vagrant, as described
in the :ref:`multi-machine setup docs <multi_machine_environment>`.

Ubuntu 20.04 setup
^^^^^^^^^^^^^^^^^^

Install libvirt and QEMU:

.. code:: sh

   sudo apt-get update
   sudo apt-get install libvirt-bin libvirt-dev qemu-utils qemu virt-manager
   sudo /etc/init.d/libvirt-bin restart

Add your user to the libvirtd group:

.. code:: sh

   sudo addgroup libvirtd
   sudo usermod -a -g libvirtd $USER

Install the required Vagrant plugins for converting and using libvirt boxes:

.. code:: sh

   vagrant plugin install vagrant-libvirt
   vagrant plugin install vagrant-mutate

.. note:: If Vagrant is already installed it may not recognize libvirt as a
   valid provider. In this case, remove Vagrant with ``sudo apt-get remove
   vagrant`` and reinstall it.

Log out, then log in again. Verify that libvirt is installed and KVM is available:

.. code:: sh

   libvirtd --version
   kvm-ok


Debian stable setup
^^^^^^^^^^^^^^^^^^^

Install Vagrant, libvirt, QEMU, and their dependencies:

.. code:: sh

   sudo apt-get update
   sudo apt-get install -y vagrant vagrant-libvirt libvirt-daemon-system qemu-kvm virt-manager
   sudo apt-get install -y ansible rsync
   vagrant plugin install vagrant-libvirt
   vagrant plugin install vagrant-mutate
   sudo usermod -a -G libvirt $USER
   sudo systemctl restart libvirtd

Add your user to the kvm group to give it permission to run KVM:

.. code:: sh

   sudo usermod -a -G kvm $USER
   sudo rmmod kvm_intel
   sudo rmmod kvm
   sudo modprobe kvm
   sudo modprobe kvm_intel

Log out, then log in again. Verify that libvirt is installed and your system
supports KVM:

.. code:: sh

   sudo libvirtd --version
   [ `egrep -c 'flags\s*:.*(vmx|svm)' /proc/cpuinfo` -gt 0 ] &&  \
   echo "KVM supported!" || echo "KVM not supported..." 

Set libvirt as the default provider
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Set the default Vagrant provider to ``libvirt``:

.. code:: sh

   echo 'export VAGRANT_DEFAULT_PROVIDER=libvirt' >> ~/.bashrc
   export VAGRANT_DEFAULT_PROVIDER=libvirt


Convert Vagrant boxes to libvirt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Convert the VirtualBox images for Focal from ``virtualbox`` to ``libvirt`` format:

.. code:: sh

   vagrant box add --provider virtualbox bento/ubuntu-20.04
   vagrant mutate bento/ubuntu-20.04 libvirt

You can now use the libvirt-backed VM images to develop against
the SecureDrop multi-machine environment.

.. _prod_install_from_tails:

Install from an Admin Workstation VM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In SecureDrop, admin tasks are performed from a Tails *Admin Workstation*.
You should configure a Tails VM in order to install the SecureDrop production VMs
by following the instructions in the :ref:`Virtualizing Tails <virtualizing_tails>`
guide.

Once you're prepared the *Admin Workstation*, you can start each VM:

.. code:: sh

  molecule create -s libvirt-focal-prod

At this point you should be able to SSH into both ``app-prod`` and ``mon-prod``.
From here you can follow the :ref:`server configuration instructions
<test_connectivity>` to test connectivity and prepare the servers. These
instructions will have you generate SSH keys and use ``ssh-copy-id`` to transfer
the key onto the servers.

.. note:: If you have trouble SSHing to the servers from Ansible, remember
          to remove any old ATHS files in ``install_files/ansible-base``.

Now from your *Admin Workstation*, set up the administration environment with:

.. code:: sh

  cd ~/Persistent/securedrop
  ./securedrop-admin setup

If you want to enable HTTPS for the source interface, you can generate a test CA cert,
server key, and server cert using the following commands:

.. code:: sh

  sudo apt-get install make
  make self-signed-https-certs

This will generate the files ``securedrop_source_onion.ca``, ``securedrop_source_onion.crt``,
and ``securedrop_source_onion.key`` in the ``install_files/ansible-base`` directory, ready
for use in the next step.

.. important:: The self-signed certificates should not be used in a live instance. They are
  provided for development and testing purposes only.

Finally, configure and install SecureDrop on the VMs using the commands:

.. code:: sh

  ./securedrop-admin sdconfig
  ./securedrop-admin install

.. note:: The sudo password for the ``app-prod`` and ``mon-prod`` servers is by
          default ``vagrant``.

After the installation is complete, you can configure your Admin Workstation to SSH
into each VM via:

.. code:: sh

  ./securedrop-admin tailsconfig
