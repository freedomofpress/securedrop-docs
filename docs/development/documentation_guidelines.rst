Documentation Guidelines
========================

SecureDrop's documentation is available at https://docs.securedrop.org. It is
written in `reStructuredText`_ (reST) and hosted by `Freedom of the Press Foundation`_
using a theme by `Read the Docs`_. The documentation files
are stored in the ``docs/`` directory of the `SecureDrop docs repository
<https://github.com/freedomofpress/securedrop-docs>`_.

.. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
.. _Freedom of the Press Foundation: https://freedom.press/
.. _Read the Docs: https://docs.readthedocs.io/en/latest/index.html


Documentation versions
----------------------

.. include:: ../includes/docs-branches.txt


Updating Documentation
----------------------

To get started editing the docs:

.. _clone_the_rep:

#. Clone the SecureDrop documentation repository:

   .. code:: sh

      git clone https://github.com/freedomofpress/securedrop-docs.git


#. Install the dependencies:

   .. include:: ../includes/virtualenv.txt

   .. code:: sh

      pip install --require-hashes -r requirements/requirements.txt


   .. _build_the_docs:

#. Build the docs for viewing in your web browser:

   .. code:: sh

      make docs

   You can then preview the documentation at http://127.0.0.1:8000. Navigate to
   the ``docs/`` directory to make changes to the documentation
   rendered on https://docs.securedrop.org.
   The documentation pages will automatically rebuild in the browser
   window, as you make changes; you don't need to refresh the page manually.

   After performing lint checks, open a PR against the ``main`` branch
   of the `SecureDrop docs repository <https://github.com/freedomofpress/securedrop-docs>`_.


Testing Documentation Changes
-----------------------------

You can check for formatting violations by running the linting option:

   .. code:: sh

      make docs-lint

The ``make docs`` command will display warnings if mistakes are found, but will
still build the documentation. Using ``make docs-lint`` will convert any warnings
to errors, causing the build to fail.

To test the documentation for broken links, run the following command from
a reliable internet connection:

   .. code:: sh

      make docs-linkcheck


Project maintainers will need to approve the PR before it can be merged.

.. include:: ../includes/squash-commits.txt

Pushing to a contributor fork
-----------------------------
As a maintainer, you can push directly to a contributor fork, as long as there
is an active Pull Request corresponding to the branch you are pushing to, and
you have added the contributor remote with authentication enabled (i.e. the ``url``
value in ``.git/config`` starts with ``git@github.com``).

.. _updating_screenshots:

Updating Screenshots
--------------------

The user guides for SecureDrop contain screenshots of the web applications.
To update these screenshots automatically you can run this command from within
your main SecureDrop repository checkout:

.. code:: sh

   DOCS_REPO_DIR=/path/to/docs make update-user-guides

This will generate screenshots for each page in the web application and copy
them to the folder ``docs/images/manual/screenshots`` in your documentation
repository checkout, where they will replace the existing screenshots. Stage for
commit any screenshots you wish to update. If you wish to update all screenshots,
simply stage for commit all changed files in that directory.


Style Guide
-----------

Please see the `reStructuredText`_ Primer by the Sphinx project as a reference
for writing in the markup language used for this documentation.

.. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html


Code Blocks
^^^^^^^^^^^

Ensure that example commands in codeblocks are easy to copy and paste.
Do not prepend the ``$`` shell prompt indicator to example commands:

  .. code::

     echo hello

In the context of a terminal session with both typed commands and printed
output text, use ``$`` before the typed commands:

  .. code::

     $ echo hello
     hello
     $ echo sunshine
     sunshine


Date Format
^^^^^^^^^^^
Follow AP guidelines for formatting dates. Don't use the ISO format for adding
dates to the documentation.

To avoid confusion, format dates in the documentation as Month_Name Day, Year:

  .. code::

     October 13, 2020

  not

  .. code::

     13 October, 2020
     13/10/2020
     10/13/2020
     10/13/20
     2020-10-13
     2020-Oct-13



File Paths
^^^^^^^^^^

:ref:`Cloning<clone_the_rep>` the SecureDrop git repository creates a directory
called ``securedrop``. This ``securedrop`` directory also contains a
``securedrop`` subdirectory for app code.

.. code::

     .
     ├── securedrop
     │   │
     │  ...
     │   ├── securedrop
    ... ...

To avoid confusion, paths to files anywhere inside the SecureDrop git repository
should be written as ``./some_dir/file``, where ``.`` is the top level directory
of the SecureDrop repo.

Use absolute paths when refering to files outside the SecureDrop repository:
``/usr/local/bin/tor-browser``.


Glossary
^^^^^^^^

Text taken directly from a user interface is in **bold face**.

    "Once you’re sure you have the right drive, click **Format Drive**."

SecureDrop-specific :doc:`glossary <../glossary>` is in *italics*.

    "To get started, you’ll need two Tails drives: one for the *Admin
    Workstation* and one for the *Secure Viewing Station*."

When referring to virtual machines in the development environment, use
lowercase for the name:

    app-staging VM


Line Wrapping
^^^^^^^^^^^^^

Lines in the plain-text documentation files should wrap at 80 characters. (Some
exceptions: complex code blocks showing example commands, or long URLs.)


Usage and Style
^^^^^^^^^^^^^^^

To avoid confusion, lists should include the "Oxford comma":

    "You will need an email address, a public GPG key for that address, and the
    fingerprint for that key."

Capitalize all section headings in title case:

  .. code::

     Before You Begin
     ================

     Set up the Environment
     ----------------------

  not

  .. code::

     Before you begin
     ================

     Set up the environment
     ----------------------
