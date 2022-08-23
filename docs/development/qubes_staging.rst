Virtual Environments: Using Qubes
=================================

SecureDrop currently uses Ubuntu Focal as its server OS.
The instructions below cover setting up a SecureDrop staging environment
using Focal under Qubes.

It is assumed that you have an up-to-date Qubes R4.1 installation on a compatible
laptop, with at least 16GB RAM and 60GB free disk space. The SecureDrop server VMs
run Tor locally instead of using ``sys-whonix``, so the system clock must be set
accurately for Tor to start and hidden services to be available.

Overview
--------
Follow the the Qubes platform instructions in :doc:`setup_development`
to create a Debian 10 ``sd-dev`` Standalone VM. Once done, we'll create three new
Standalone (HVM) Qubes VMs for use with staging:

- ``sd-staging-base-focal``, a base VM for cloning reusable staging VMs
- ``sd-staging-app-base-focal``, a base VM for the *SecureDrop Application Server*
- ``sd-staging-mon-base-focal``, a base VM for the *SecureDrop Monitor Server*

Download Ubuntu server ISO
----------------------------

On ``sd-dev``, download the latest Ubuntu server ISO for Focal,
along with corresponding checksum and signature files. See the
:ref:`hardware installation docs <download_ubuntu>`
for detailed instructions. If you opt for the command line instructions, omit
the ``torify`` prepended to the ``curl`` command.

Create the base VM
------------------

We're going to build a single, minimally configured Ubuntu VM.
Once it's bootable, we'll clone it for the application and monitoring VMs.

In ``dom0``, do the following:

.. code:: sh

   qvm-create sd-staging-base-focal --class StandaloneVM --property virt_mode=hvm --label green
   qvm-volume extend sd-staging-base-focal:root 20g
   qvm-prefs sd-staging-base-focal memory 2000
   qvm-prefs sd-staging-base-focal maxmem 2000
   qvm-prefs sd-staging-base-focal kernel ''

The commands above will create a new StandaloneVM, expand the storage space
and memory available to it, as well as disable the integrated kernel support.
The SecureDrop install process will install a custom kernel.

Boot into installation media
----------------------------

In ``dom0``:

.. code:: sh

   qvm-start sd-staging-base-focal --cdrom=sd-dev:$ISO_PATH

where ``ISO_PATH`` is the full path to the Ubuntu ISO previously downloaded on ``sd-dev``.

Next, choose **Install Ubuntu**.

For the most part, the install process matches the
:ref:`hardware install flow <install_ubuntu>`, with a few exceptions:

  -  **Subnet:** 10.137.0.0/24
  -  **Address:** use value returned by ``qvm-prefs sd-staging-base-focal ip``
  -  **Gateway:** use value returned by ``qvm-prefs sd-staging-base-focal visible_gateway``
  -  **Name servers:** 10.139.1.1,10.139.1.2
  -  **Search domains:** *should be left blank*
  -  **Your server's name:** ``sd-staging-base-focal``

Make sure to configure LVM and use **Virtual disk 1 (xvda 20.0GB Xen Virtual Block device)**
when asked for a target partition during installation. It should be the default option.

You'll be prompted to add a "regular" user for the VM: this is the user you'll be
using later to SSH into the VM. We're using a standardized name/password pair:
``sdadmin/securedrop``.

Once installation is done, let the machine shut down and then restart it with

.. code:: sh

   qvm-start sd-staging-base-focal

in ``dom0``. You should get a login prompt.

Initial VM configuration
------------------------

Before cloning this machine, we'll update software to reduce provisioning time
on the staging VMs. In the new ``sd-staging-base-focal`` VM's console, do:

.. code:: sh

   sudo apt update
   sudo apt dist-upgrade -y

Before we continue, let's allow your user to ``sudo`` without their password.
Edit ``/etc/sudoers`` using ``visudo`` to make the sudo group line look like

.. code:: sh

   %sudo    ALL=(ALL) NOPASSWD: ALL


Finally, update the machine's Grub configuration to use a consistent Ethernet device
name across kernel versions. Edit the file ``/etc/default/grub``, changing the line:

.. code:: sh

   GRUB_CMDLINE_LINUX=""

to

.. code:: sh

   GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"

When initial configuration is done, run ``qvm-shutdown sd-staging-base-focal`` to shut it down.

Clone VMs
---------

We're going configure the VMs to use specific IP addresses, which will make
various routing issues easier later. We'll also tag the VMs for management
by the ``sd-dev`` VM. Doing so will require Qubes RPC policy changes,
documented below. Run the following in ``dom0``:

.. code:: sh

   qvm-clone sd-staging-base-focal sd-staging-app-base-focal
   qvm-clone sd-staging-base-focal sd-staging-mon-base-focal
   qvm-prefs sd-staging-app-base-focal ip 10.137.0.50
   qvm-prefs sd-staging-mon-base-focal ip 10.137.0.51
   qvm-tags sd-staging-app-base-focal add created-by-sd-dev
   qvm-tags sd-staging-mon-base-focal add created-by-sd-dev

Now start both new VMs:

.. code:: sh

   qvm-start sd-staging-app-base-focal
   qvm-start sd-staging-mon-base-focal

On the consoles which eventually appear, you should be able to log in with
``sdadmin/securedrop``.

Configure cloned VMs
~~~~~~~~~~~~~~~~~~~~

We'll need to fix each machine's idea of its own IP. In the console for each machine,
edit ``/etc/netplan/00-installer-config.yaml`` to update the ``addresses`` entry with the machine's IP.

Edit ``/etc/hosts`` on each host to include the hostname and IP for itself.
Use ``app-staging`` and ``mon-staging`` as appropriate.

Next, on each host edit ``/etc/hostname`` to reflect the machine's name.

Halt each machine, then restart each from ``dom0``. The prompt in each console
should reflect the correct name of the VM. Confirm you have network access by
running ``ping freedom.press``. It should show no errors.

Inter-VM networking
~~~~~~~~~~~~~~~~~~~

We want to be able to SSH connections from ``sd-dev`` to these new standalone VMs.
In order to do so, we have to adjust the firewall on ``sys-firewall``.

.. tip::

   See the official Qubes guide on configuring `inter-VM networking`_ for details.

.. _`inter-VM networking`: https://www.qubes-os.org/doc/firewall/#enabling-networking-between-two-qubes

Let's get the IP address of ``sd-dev``. On ``dom0``:

.. code:: sh

   qvm-prefs sd-dev ip

Get a shell on ``sys-firewall``. Create or edit
``/rw/config/qubes-firewall-user-script``, to include the following:

.. code:: sh

   sd_dev="<sd-dev-addr>"
   sd_app="10.137.0.50"
   sd_mon="10.137.0.51"

   iptables -I FORWARD 2 -s "$sd_dev" -d "$sd_app" -j ACCEPT
   iptables -I FORWARD 2 -s "$sd_dev" -d "$sd_mon" -j ACCEPT
   iptables -I FORWARD 2 -s "$sd_app" -d "$sd_mon" -j ACCEPT
   iptables -I FORWARD 2 -s "$sd_mon" -d "$sd_app" -j ACCEPT

Run those commands on ``sys-firewall`` with

.. code:: sh

   sudo sh /rw/config/qubes-firewall-user-script

Now from ``sd-dev``, you should be able to do

.. code:: sh

   ssh sdadmin@10.137.0.50

and log in with the password ``securedrop``.

SSH using keys
~~~~~~~~~~~~~~

.. tip::
   You likely already have an SSH keypair configured for access to GitHub.
   If not, create one with ``ssh-keygen -b 4096 -t rsa``. The configuration
   logic will use the key at ``~/.ssh/id_rsa`` to connect to the VMs.

Later we'll be using Ansible to provision the application VMs, so we should
make sure we can SSH between those machines without needing to type
a password. On ``sd-dev``:

.. code:: sh

   ssh-copy-id sdadmin@10.137.0.50
   ssh-copy-id sdadmin@10.137.0.51

Confirm that you're able to ssh as user ``sdadmin`` from ``sd-dev`` to both IP
addresses without a password.

SecureDrop Installation
-----------------------

We're going to configure ``sd-dev`` to build the SecureDrop ``.deb`` files,
then we're going to build them, and provision ``sd-staging-app`` and ``sd-staging-mon``.
Follow the instructions in the :doc:`developer documentation <setup_development>`
to set up the development environment.

Once finished, build the Debian packages for installation on the staging VMs:

.. code::  sh

    make build-debs

Managing Qubes RPC for Admin API capability
-------------------------------------------

We're going to be running Qubes management commands on ``sd-dev``,
which requires some additional software. Install it with

.. code::  sh

    sudo apt install qubes-core-admin-client

You'll need to grant the ``sd-dev`` VM the ability to create other VMs,
by editing the Qubes RPC policies in ``dom0``. Here is an example of a
permissive policy, sufficient to grant ``sd-dev`` management capabilities
over VMs it creates. The lines below should be inserted at the beginning of their
respective policy files, before other more general rules:

.. todo::

   Reduce these grants to the bare minimum necessary. We can likely
   pare them down to a single grant, preferably with tags-based control.

.. code:: sh

   /etc/qubes/policy.d/include/admin-local-rwx:
     sd-dev @tag:created-by-sd-dev allow target=@adminvm

   /etc/qubes/policy.d/include/admin-global-rwx:
     sd-dev @adminvm allow target=@adminvm
     sd-dev @tag:created-by-sd-dev allow target=@adminvm

.. tip::

   See the Qubes documentation for details on leveraging the `Admin API`_.

.. _`Admin API`: https://www.qubes-os.org/doc/admin-api/

Creating staging instance
-------------------------

After creating the StandaloneVMs as described above:

* ``sd-dev``
* ``sd-staging-base-focal``
* ``sd-staging-app-base-focal``
* ``sd-staging-mon-base-focal``

And after building the SecureDrop .debs, we can finally provision the staging
environment:

.. code:: sh

    make staging

The commands invoke the appropriate Molecule scenario for your choice of ``focal``.
You can also run constituent Molecule actions directly, rather than using
the Makefile target:

.. code:: sh

   molecule create -s qubes-staging-focal
   molecule converge -s qubes-staging-focal
   molecule test -s qubes-staging-focal

That's it. You should now have a running, configured SecureDrop staging instance
running on your Qubes machine. For day-to-day operation, you should run
``sd-dev`` in order to make code changes, and use the Molecule commands above
to provision staging VMs on-demand. To remove the staging instance, use the Molecule command:

.. code:: sh

   molecule destroy -s qubes-staging-focal

Accessing the Journalist Interface (Staging) in Whonix-based VMs
----------------------------------------------------------------
.. warning::
   These instructions are only appropriate for a staging setup and should not be
   used to access a production instance of SecureDrop.

To access the *Source* and *Journalist Interfaces* (staging) in a Debian- or
Fedora-based VM, follow the instructions :doc:`here <virtual_environments>`.

To use a Whonix-based VM, the following steps are required to configure access
to the *Journalist Interface* (staging).

In ``sd-dev``
~~~~~~~~~~~~~

You will have to copy the ``app-journalist.auth_private`` file (located in
your ``sd-dev`` VM in ``${SECUREDROP_HOME}/install_files/ansible-base`` and
generated after a successful staging build) into your Whonix gateway
VM. On standard Qubes installations this VM is called ``sys-whonix``.

To do this, in an ``sd-dev`` terminal, run the command:

.. code:: sh

   qvm-copy ${SECUREDROP_HOME})/install_files/ansible-base/app-journalist.auth_private

and select ``sys-whonix`` in the resulting permissions dialog.

In the Whonix Gateway
~~~~~~~~~~~~~~~~~~~~~

Open a terminal in ``sys-whonix`` and create a directory with appropriate
ownership and permissions, then move your credential file there:

.. code:: sh

   sudo mkdir -p /var/lib/tor/onion_auth
   sudo mv ~/QubesIncoming/sd-dev/app-journalist.auth_private /var/lib/tor/onion_auth
   sudo chown --recursive debian-tor:debian-tor /var/lib/tor/onion_auth

Next, edit the Tor configuration so it recognizes the directory
containing your credentials:

.. code:: sh

   sudo vi /usr/local/etc/torrc.d/50_user.conf

In this file, enter the following:

.. code:: sh

   ClientOnionAuthDir /var/lib/tor/onion_auth

Save and close the file. Finally, reload Tor by clicking
**Qubes Application Menu > sys-whonix > Reload Tor**

At this point, you should be able to access the *Journalist Interface*
(staging) in a Whonix VM that uses ``sys-whonix`` as its gateway.

Note that you will have to replace the ``app-journalist.auth_private`` file
and reload Tor on the Whonix gateway every time you rebuild the staging environment.
