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

Tails virtualization via libvirt
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Two separate methods are described below for running Tails via libvirt:

* a simple method, following the Tails documentation to create a VM with a persistent volume,

* and a more complicated method that supports VM snapshots, but involves modifying the
  Tails installer to allow for installation on the VM's virtual hard drive.

The simple setup works for most development use cases, but if you are working on
features that modify the Tails installation then having the ability to take VM snapshots
will save time in the long run.

In either case, we recommend cloning the SecureDrop repository into the persistent volume for
testing and development, instead of attempting to mount a folder from the host
operating system.


Creating a simple Tails VM
^^^^^^^^^^^^^^^^^^^^^^^^^^

* First, follow the Tails virt-manager instructions for
  `running Tails from a USB image <https://tails.boum.org/doc/advanced_topics/virtualization/virt-manager/index.en.html#index4h1>`__.

* Then boot into the new Tails VM, and `configure Persistent Storage <https://tails.boum.org/doc/first_steps/persistence/index.en.html>`__.

Creating a Tails VM with snapshot support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It's also possible to set up Tails in a VM that supports
snapshots. Instead of creating the VM with the Tails USB image, start
by downloading a Tails ISO image. In `virt-manager`:

- Choose "New virtual machine" from the "File" menu.
- Step 1: Choose "Local install media (ISO image or CDROM)"
- Step 2: Choose "Use ISO image" and select the Tails ISO you downloaded. Specify "Linux" for "OS Type" and "Debian Stretch" for "Version".
- Step 3: Specify at least 2048MiB of memory
- Step 4: The defaults are fine.
- Step 5: Set the name to something including the Tails version, like "tails316", if you plan to work with more than one.

Click "Finish" and Tails will boot.

Install Tails
"""""""""""""

Next you will install Tails onto the Virtual Hard Disk Image. Start
the VM, boot to Tails, enter an administration password, and start
Tails.

.. note:: For all the instructions that follow, you will need to
          configure an administration password each time you boot
          Tails.

1. Copy the following patch and save it in a file in your Tails VM
   named ``installer.patch``:

.. code:: python

  --- /usr/lib/python2.7/dist-packages/tails_installer/creator.py      2018-01-22 14:59:40.000000000 +0100
  +++ /usr/lib/python2.7/dist-packages/tails_installer/creator.py.mod  2018-03-05 05:15:00.000000000 -0800
  @@ -595,16 +595,6 @@ class LinuxTailsInstallerCreator(TailsInstallerCreator):
                   self.log.debug('Skipping non-removable device: %s'
                                  % data['device'])

  -            # Only pay attention to USB and SDIO devices, unless --force'd
  -            iface = drive.props.connection_bus
  -            if iface != 'usb' and iface != 'sdio' \
  -               and self.opts.force != data['device']:
  -                self.log.warning(
  -                    "Skipping device '%(device)s' connected to '%(interface)s' interface"
  -                    % {'device': data['udi'], 'interface': iface}
  -                )
  -                continue
  -
               # Skip optical drives
               if data['is_optical'] and self.opts.force != data['device']:
                   self.log.debug('Skipping optical device: %s' % data['device'])
  --- /usr/lib/python2.7/dist-packages/tails_installer/gui.py      2018-01-22 14:59:40.000000000 +0100
  +++ /usr/lib/python2.7/dist-packages/tails_installer/gui.py.mod  2018-03-05 05:15:00.000000000 -0800
  @@ -568,16 +568,6 @@ class TailsInstallerWindow(Gtk.ApplicationWindow):
                       self.devices_with_persistence.append(info['parent'])
                       continue
                   pretty_name = self.get_device_pretty_name(info)
  -                # Skip devices with non-removable bit enabled
  -                if not info['removable']:
  -                    message =_('The USB stick "%(pretty_name)s"'
  -                               ' is configured as non-removable by its'
  -                               ' manufacturer and Tails will fail to start on it.'
  -                               ' Please try installing on a different model.') % {
  -                               'pretty_name':  pretty_name
  -                               }
  -                    self.status(message)
  -                    continue
                   # Skip too small devices, but inform the user
                   if not info['is_device_big_enough_for_installation']:
                       message =_('The device "%(pretty_name)s"'

2. Now run the following two commands in a Terminal in your Tails VM:

.. code:: sh

  sudo patch -p0 -d/ < installer.patch
  sudo /usr/bin/python -tt /usr/bin/tails-installer -u -n --clone -P -m -x

3. The **Tails Installer** will appear. Click **Install Tails**.
4. Once complete, navigate to **Applications**, **Utilities** and open **Disks**.
5. Click on the disk named "Tails" and click the Play icon to mount the disk.
6. Next open ``/media/amnesia/Tails/syslinux/live*.cfg`` in an editor
   and delete all instances of ``live-media=removable``.
7. Shut down the VM.

Configure Persistence
"""""""""""""""""""""

1. Start the VM with an admin password configured.
2. Copy the following patch to the Tails VM and save it as ``persistence.patch``:

.. code-block:: 

   --- /usr/share/perl5/Tails/Persistence/Setup.pm	2017-06-30 09:56:25.000000000 +0000
   +++ /usr/share/perl5/Tails/Persistence/Setup.pm.mod	2017-07-20 07:17:48.472000000 +0000
   @@ -404,19 +404,6 @@

        my @checks = (
            {
   -            method  => 'drive_is_connected_via_a_supported_interface',
   -            message => $self->encoding->decode(gettext(
   -                "Tails is running from non-USB / non-SDIO device %s.")),
   -            needs_drive_arg => 1,
   -        },
   -        {
   -            method  => 'drive_is_optical',
   -            message => $self->encoding->decode(gettext(
   -                "Device %s is optical.")),
   -            must_be_false    => 1,
   -            needs_drive_arg => 1,
   -        },
   -        {
                method  => 'started_from_device_installed_with_tails_installer',
                message => $self->encoding->decode(gettext(
                    "Device %s was not created using Tails Installer.")),

3. To apply the patch, from the Terminal run:

.. code:: sh

  sudo patch -p0 -d/ < persistence.patch

4. Navigate to **Applications** then **Tails** and click **Configure
   persistent volume**. Configure a persistent volume enabling all persistence
   options.
