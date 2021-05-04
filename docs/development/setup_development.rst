Setting Up the Development Environment
======================================

.. include:: ../includes/docs-branches.txt

Overview
--------

SecureDrop is a multi-machine design. To make development and testing
easy, we provide a set of virtual environments, each tailored for a
specific type of development task. We use Vagrant, Molecule, and
Docker and our Ansible playbooks can provision these environments on
either virtual machines or physical hardware.

Quick Start
-----------

The Docker based environment is suitable for developing the web application
and updating the documentation.

Follow the instructions below to install the requirements for the Docker-based
environment for your operating system.

Ubuntu or Debian GNU/Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~
Run the following commands to update the package index and to install Git and ``make``:

.. code:: sh

   sudo apt-get update
   sudo apt-get install -y make git

We recommend using the stable version of Docker CE (Community Edition) which can
be installed via the official documentation links:

* `Docker CE for Ubuntu`_
* `Docker CE for Debian`_

Make sure to follow the `post-installation steps for Linux`_.


Fedora Linux
~~~~~~~~~~~~
.. note:: To install Docker Engine, you need the 64-bit version of Fedora 30 or higher.

Run the following command to update the package index and to install Git and ``make``:

.. code:: sh

   sudo dnf install -y make git


We recommend using the stable version of Docker CE (Community Edition) which can
be installed via the official documentation link:

* `Docker CE for Fedora`_

Make sure to follow the `post-installation steps for Linux`_.

.. _`Docker CE for Ubuntu`: https://docs.docker.com/engine/install/ubuntu/
.. _`Docker CE for Debian`: https://docs.docker.com/engine/install/debian/
.. _`Docker CE for Fedora`: https://docs.docker.com/engine/install/fedora/
.. _`post-installation steps for Linux`: https://docs.docker.com/engine/install/linux-postinstall/


macOS
~~~~~

Install Docker_.

.. _Docker: https://hub.docker.com/editions/community/docker-ce-desktop-mac


Qubes
~~~~~

Create a StandaloneVM based on Debian 10, called ``sd-dev``.
You can use the **Q** menu to configure a new VM, or run
the following in ``dom0``:

.. code:: sh

   qvm-clone --class StandaloneVM debian-10 sd-dev
   qvm-start sd-dev
   qvm-sync-appmenus sd-dev

The commands above create a new StandaloneVM, boot it, and then update
the Qubes menus with applications within that VM. Open a terminal in
``sd-dev``, and proceed with installing `Docker CE for Debian`_.

.. tip:: If you experience an error with the ``aufs-dkms`` dependency when
   installing Docker CE, you can safely skip that package using the
   ``--no-install-recommends`` argument for ``apt``.

Fork & Clone the Repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now you are ready to get your own copy of the source code.
Visit our repository_, fork it, and clone it on your local machine.

.. code:: sh

   git clone git@github.com:<your_github_username>/securedrop.git

.. note:: Pull requests should be opened against the ``develop`` branch of our
   repository_, which is the primary branch used for development.


Using the Docker Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Docker based helpers are intended for rapid development on the
SecureDrop web application and documentation. They use Docker images
that contain all the dependencies required to run the tests, a demo
server etc.

.. tip:: When run for the first time, building Docker images will take
         a few minutes, even one hour when your Internet connection is
         not fast. If you are unsure about what happens, you can get a
         more verbose output by setting the environment
         variable ``export DOCKER_BUILD_VERBOSE=true``.

The SecureDrop repository is bind mounted into the
container and files modified in the container are also modified in the
repository. This container has no security hardening or monitoring.

To get started, you can try the following:

.. code:: sh

   cd securedrop
   make dev                                               # run development servers
   make test                                              # run tests
   securedrop/bin/dev-shell bin/run-test tests/functional # functional tests only
   securedrop/bin/dev-shell bash                          # shell inside the container

.. tip:: The interactive shell in the container does not run
         ``redis``, ``Xvfb`` etc.  However you can import shell helper
         functions with ``source bin/dev-deps`` and call ``run_xvfb``,
         ``maybe_create_config_py`` etc.

SecureDrop consists of two separate web applications (the Source Interface and
the *Journalist Interface*) that run concurrently. In the development environment
they are configured to detect code changes and automatically reload whenever a
file is saved. They are made available on your host machine by forwarding the
following ports:

* Source Interface: `localhost:8080 <http://localhost:8080>`__
* *Journalist Interface*: `localhost:8081 <http://localhost:8081>`__

You should use Tor Browser to test web application changes, :ref:`see here for instructions <using_tor_with_dev_env>`.

A test administrator (``journalist``) and non-admin user (``dellsberg``) are
created by default when running ``make dev``. In addition, sources and
submissions are present. The test users have the following credentials. Note that
the password and TOTP secret are the same for both accounts for convenience during
development.

* **Username:** ``journalist`` or ``dellsberg``
* **Password:** ``correct horse battery staple profanity oil chewy``
* **TOTP secret:** ``JHCO GO7V CER3 EJ4L``

If you need to generate the six digit two-factor code, use the TOTP secret in
combination with an authenticator application that implements
`RFC 6238 <https://tools.ietf.org/html/rfc6238>`__, such as
`FreeOTP <https://freeotp.github.io/>`__ (Android and iOS) or
`oathtool <https://www.nongnu.org/oath-toolkit/oathtool.1.html>`__
(command line tool, multiple platforms). Instead of typing the TOTP code, you
can simply scan the following QR code:

.. image:: ../images/devenv/test-users-totp-qrcode.png

You can also generate the two-factor code using the Python interpreter:

.. code:: python

  >>> import pyotp
  >>> pyotp.TOTP('JHCOGO7VCER3EJ4L').now()
  u'422038'

.. _multi_machine_environment:

Setting Up a Multi-Machine Environment
--------------------------------------

.. note:: You do not need this step if you only plan to work on the
   web application or the documentation.

To get started, you will need to install Vagrant, Libvirt, Docker, and
Ansible on your development workstation.


Ubuntu or Debian GNU/Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: Tested on: Debian GNU/Linux 10 Buster

.. code:: sh

   sudo apt-get update
   sudo apt-get install -y build-essential libssl-dev libffi-dev python3-dev \
       dpkg-dev git linux-headers-$(uname -r)

We recommend using the most recent version of Vagrant available in your distro's
package repositories. For Debian Stable, that's ``2.2.3`` at the time
of this writing. Older versions of Vagrant has been known to cause problems
(`GitHub #932`_, `GitHub #1381`_). If ``apt-cache policy vagrant`` says your
candidate version is not at least 1.8.5, you should download the current version
from the `Vagrant Downloads page`_ and then install it.

.. code:: sh

    # If your OS vagrant is recent enough
    sudo apt-get install vagrant
    # OR this, if you downloaded the deb package.
    sudo dpkg -i vagrant.deb

.. _`Vagrant Downloads page`: https://www.vagrantup.com/downloads
.. _`GitHub #932`: https://github.com/freedomofpress/securedrop/pull/932
.. _`GitHub #1381`: https://github.com/freedomofpress/securedrop/issues/1381

.. warning:: We do not recommend installing vagrant-cachier. It destroys apt’s
            state unless the VMs are always shut down/rebooted with Vagrant,
            which conflicts with the tasks in the Ansible playbooks. The
            instructions in Vagrantfile that would enable vagrant-cachier are
            currently commented out.

Finally, install Ansible so it can be used with Vagrant to automatically
provision VMs. We recommend installing Ansible from PyPi with ``pip`` to ensure
you have the latest stable version.

.. code:: sh

    sudo apt-get install python3-pip

The version of Ansible recommended to provision SecureDrop VMs may not be the
same as the version in your distro's repos, or may at some point flux out of
sync. For this reason, and also just as a good general development practice, we
recommend using a Python virtual environment to install Ansible and other
development-related tooling. Using `virtualenvwrapper
<https://virtualenvwrapper.readthedocs.io/en/stable/>`_:

.. code:: sh

    sudo apt-get install virtualenvwrapper
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    mkvirtualenv -p /usr/bin/python3 securedrop

.. note:: You'll want to add the command to source ``virtualenvwrapper.sh``
          to your ``~/.bashrc`` (or whatever your default shell configuration
          file is) so that the command-line utilities ``virtualenvwrapper``
          provides are automatically available in the future.

macOS
~~~~~

Developers on macOS should use the Docker-based container environment.
We don't support running VMs on macOS.

Fork & Clone the Repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now you are ready to get your own copy of the source code.
Visit our repository_ fork it and clone it on you local machine:


.. code:: sh

   git clone git@github.com:<your_github_username>/securedrop.git

.. _repository: https://github.com/freedomofpress/securedrop

Install Python Requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~

SecureDrop uses many third-party open source packages from the Python community.
Ensure your virtualenv is activated and install the packages.

.. code:: sh

    pip install --no-deps --require-hashes -r securedrop/requirements/python3/develop-requirements.txt

.. note:: You will need to run this everytime new packages are added.

Qubes
~~~~~

To configure a multi-machine evironment in Qubes, follow the Quick Start instructions above to
create a standalone VM named ``sd-dev``, then follow the Linux instructions above to install the
required packages.

Then, complete the steps described in :doc:`qubes_staging`.
