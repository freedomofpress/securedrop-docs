.. _upgrade_testing:

Upgrade Testing using Molecule
==============================

The SecureDrop project includes Molecule scenarios for developing and testing against
multi-server configurations, including a scenario to simulate the process of upgrading an
existing system. This document explains how to work with this scenario to test
features that make potentially release-breaking changes such as database
schema updates.

The Molecule upgrade scenario sets up a local apt server, to imitate
how new package versions will be installed in production. You'll need
to use a virtualized Admin Workstation to configure the base server VMs
with the current stable version, prior to testing the upgrade.

.. note:: The upgrade scenario uses QEMU/KVM via Vagrant's libvirt provider.
   If you haven't already done so, you'll need to set up the libvirt provider
   before proceeding. For more information, see :ref:`libvirt_provider`.

.. _upgrade_testing_local:

Upgrade testing using locally-built packages
--------------------------------------------

First, create prod VMs for use with the current stable version.
These machines will be upgraded with newer, locally built deb packages
in a subsequent step.

.. code:: sh

  molecule create -s libvirt-prod-focal

Next, boot your Admin Workstation VM and proceed with a full install
on these VMs, via ``./securedrop-admin install``. Make sure to run
``./securedrop-admin tailsconfig`` to finalize the installation.

Next, build the app code packages and create the environment:

.. code:: sh

 make build-debs
 make upgrade-start

The playbook will create a local apt server on your host machine, and
serve the locally built deb packages from that local endpoint.
In order to add the local apt server to the VMs, switch back to
the Admin Workstation and run:

.. code:: sh

   source admin/.venv3/bin/activate
   cd install_files/ansible-base
   ansible-playbook -vv --diff securedrop-apt-local.yml

Both VMs will now be able to be able to view newer, locally built packages.
To confirm:

.. code:: sh

   molecule login -s libvirt-prod-focal -h app-prod

From the *Application Server*:

.. code:: sh

   apt-cache-policy securedrop-app-code

The installed package version should match the latest stable version,
but the locally built package with higher version should be available
as a candidate for installation.

Upgrade testing using apt-test.freedom.press
--------------------------------------------

You can also evaluate packages on the https://apt-test.freedom.press/
repository. As above, create prod VMs and configure them via the
Admin Workstation. After installation, you can enable the ``apt-test``
repo like so:

.. code:: sh

   source admin/.venv3/bin/activate
   cd install_files/ansible-base
   ansible-playbook -vv --diff securedrop-qa.yml

Then, log into the *Application Server*:

.. code:: sh

   molecule login -s libvirt-prod-focal -h app-prod
   apt-cache policy securedrop-config

The installed package version should match the latest stable version,
with the locally built package of a higher version available
as a candidate for installation.
