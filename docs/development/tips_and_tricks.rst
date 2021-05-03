Tips & Tricks
=============

.. _using_tor_with_dev_env:

Using Tor Browser with the Development Environment
--------------------------------------------------

We strongly encourage sources to use Tor Browser when they access
the Source Interface. Tor Browser is the easiest way for the average
person to use Tor without making potentially catastrophic mistakes,
makes disabling JavaScript easy via the handy NoScript icon in the
toolbar, and prevents state about the source's browsing habits
(including their use of SecureDrop) from being persisted to disk.

Since Tor Browser is based on an older version of Firefox (usually the
current ESR release), it does not always render HTML/CSS the same as
other browsers (especially more recent versions of browsers). Therefore,
we recommend testing all changes to the web application in the Tor
Browser instead of whatever browser you normally use for web
development. Unfortunately, it is not possible to access the local
development servers by default, due to Tor Browser's proxy
configuration.

To test the development environment in Tor Browser, you need to modify Tor
Browser's default settings to prevent localhost from being resolved by the
proxy:

#. In a new tab, navigate to ``about:config``.
#. Click "I accept the Risk!"
#. In the search bar, enter ``network.proxy.allow_hijacking_localhost``.
#. The default value is true. Double-click to set it to false.

Now you should be able to navigate to ``127.0.0.1:8080`` and ``127.0.0.1:8081``
in Tor Browser. For some reason, you have to use ``127.0.0.1`` -- ``localhost``
doesn't work.

The modified value persists across restarts of Tor Browser.

.. _updating_pip_dependencies:

Upgrading or Adding Python Dependencies
---------------------------------------

We use a `pip-compile <https://nvie.com/posts/better-package-management/>`_
based workflow for adding Python dependencies. If you would like to add a Python
dependency, instead of editing the ``securedrop/requirements/python3/*.txt`` files
directly, please:

  #. Edit the relevant ``*.in`` file in ``securedrop/requirements/python3``
  #. Use the following shell script to generate
     ``securedrop/requirements/python3/*.txt`` files:

     .. code:: sh

        make update-pip-requirements

  #. Commit both the ``securedrop/requirements/python3/*.in`` and
     ``securedrop/requirements/python3/*.txt`` files

Note that application dependency changes are subject to closer review, using
`diffoscope` or a similar tool to compare the old and updated dependencies. You
can request a review when submitting a PR.

Architecture Diagrams
---------------------

Some helpful diagrams for getting a sense of the SecureDrop application
architecture are stored `here <https://github.com/freedomofpress/securedrop-docs/tree/main/docs/diagrams>`_,
including a high-level view of the SecureDrop database structure:

.. image:: ../diagrams/securedrop-database.png
  :width: 100%
