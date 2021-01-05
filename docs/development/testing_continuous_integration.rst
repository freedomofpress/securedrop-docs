.. _ci_tests:

Testing: CI
===========

The SecureDrop project uses CircleCI_ for running automated test suites on code changes.

.. _CircleCI: https://circleci.com/gh/freedomofpress/securedrop

The relevant files for configuring the CI tests are the ``Makefile`` in
the main repo, the configuration file at ``.circleci/config.yml``, and
the scripts in ``devops/``. You may want to consult the
`CircleCI Configuration Reference <https://circleci.com/docs/2.0/configuration-reference/>`__
to interpret the configuration file. Review the ``workflows`` section of the
configuration file to understand which jobs are run by CircleCI.

The files under ``devops/`` are used to create a libvirt-compatible environment on GCE.
The GCE host is used as the Ansible controller, mimicking a developer's laptop,
to provision the machines and run the :ref:`tests <config_tests>` against them.

.. note:: We skip unnecessary jobs, such as the staging run, for pull requests that only
  affect the documentation; to do so, we check whether the branch name begins with
  ``docs-``. These checks are enforced in different parts of the configuration,
  mainly within the ``Makefile``.

.. warning:: In CI, we rebase branches in PRs on HEAD of the target branch.
  This rebase does not occur for branches that are not in PRs.
  When a branch is pushed to the shared ``freedomofpress`` remote, CI will run,
  a rebase will not occur, and since opening a
  `PR does not trigger a re-build <https://discuss.circleci.com/t/pull-requests-not-triggering-build/1213>`_,
  the CI build results are not shown rebased on the latest of the target branch.
  This is important to maintain awareness of if your branch is behind the target
  branch. Once your branch is in a PR, you can rebuild, push an additional
  commit, or manually rebase your branch to update the CI results.

Running the CI Staging Environment
----------------------------------

The staging environment tests will run automatically in CircleCI, when
changes are submitted by Freedom of the Press Foundation staff (i.e. members
of the ``freedomofpress`` GitHub organization). The tests also perform
basic linting and validation, like checking for formatting errors in the
Sphinx documentation.

.. tip:: You will need a Google Cloud Platform account to proceed.
         See the `Google Cloud Platform Getting Started Guide`_ for detailed instructions.

.. _Google Cloud Platform Getting Started Guide: https://cloud.google.com/getting-started/

In addition to a GCP account, you will need a working `Docker installation`_ in
order to run the container that builds the deb packages.

You can verify that your Docker installation is working by running
``docker run hello-world`` and confirming you see "Hello from Docker" in the
output as shown below:

.. code:: sh

    $ docker run hello-world

    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    ...

.. _Docker installation: https://docs.docker.com/install/

Setup Environment Parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Source the setup script using the following command:

.. code:: sh

    source ./devops/gce-nested/ci-env.sh

You will be prompted for the values of the required environment variables. There
are some defaults set that you may want to change. You will need to export
``GOOGLE_CREDENTIALS`` with authentication details for your GCP account,
which is outside the scope of this guide.

Use Makefile to Provision Hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run ``make help`` to see the full list of CI commands in the Makefile:

.. code:: sh

    $ make help
    Makefile for developing and testing SecureDrop.
    Subcommands:
        ci-go                      Creates, provisions, tests, and destroys GCE host for testing staging environment.
        ci-go-xenial               Creates, provisions, tests, and destroys GCE host for testing staging environment under xenial.
        ci-lint                    Runs linting in linting container.
        ci-teardown                Destroys GCE host for testing staging environment.

To run the tests locally:

.. code:: sh

    make ci-go

You can use ``./devops/gce-nested/ci-runner.sh`` to provision the remote hosts
while making changes, including rebuilding the Debian packages used in the
Staging environment. See :doc:`virtual_environments` for more information.

Debugging CI Issues and Connecting to Remote Instances
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
For the staging tests, a container will be spawned on CircleCI, which will then
create a Google Compute instance with nested virtualization and will set up the
virtual environment and run the playbooks on that remote.

Cloud instances are deleted after the test run is completed, whether a test run
passes or fails. In order to debug the state of the remote instance, we must first
ensure that the instance is not automatically destroyed. Note that there is also
a cron job that destroys instances daily as well. The following is an example
of a commit to apply to a branch in order disable the deletion for the Focal staging job:

.. code:: Diff

    diff --git a/.circleci/config.yml b/.circleci/config.yml
    index 4a9b0bd4c..d9aea01b8 100644
    --- a/.circleci/config.yml
    +++ b/.circleci/config.yml
    @@ -354,13 +354,6 @@ jobs:
               BASE_OS=focal make ci-go
             no_output_timeout: 35m

    -      - run:
    -          name: Ensure environment torn down
    -          # Always report true, since env should will destroyed already
    -          # if all tests passed.
    -          command: make ci-teardown || true
    -          when: always
    -
         - store_test_results:
             path: ~/sd/junit

    diff --git a/devops/gce-nested/ci-go.sh b/devops/gce-nested/ci-go.sh
    index 850324ecc..776120df4 100755
    --- a/devops/gce-nested/ci-go.sh
    +++ b/devops/gce-nested/ci-go.sh
    @@ -16,4 +16,3 @@ export BASE_OS="${BASE_OS:-xenial}"

    ./devops/gce-nested/gce-start.sh
    ./devops/gce-nested/gce-runner.sh
    -./devops/gce-nested/gce-stop.sh
    diff --git a/devops/scripts/create-staging-env b/devops/scripts/create-staging-env
    index 3b9a2c7f8..df2ccfe3d 100755
    --- a/devops/scripts/create-staging-env
    +++ b/devops/scripts/create-staging-env
    @@ -33,7 +33,7 @@ printf "Creating staging environment via '%s'...\\n" "${securedrop_staging_scena
    virtualenv_bootstrap
    # Are we in CI? Then lets do full testing post install!
    if [ "$USER" = "sdci" ]; then
    -    molecule test -s "${securedrop_staging_scenario}"
    +    molecule test --destroy=never -s "${securedrop_staging_scenario}"
    else
       molecule "${MOLECULE_ACTION:-converge}" -s "${securedrop_staging_scenario}" "${EXTRA_ANSIBLE_ARGS[@]}"
    fi

Once that commit is pushed, run the appropriate ``staging-test-with-rebase`` job
with ssh using with CircleCI. Once logged into that container, you can ssh into the
Google Compute host:

.. code:: sh

    ssh -i /tmp/gce-nested/gce sdci@<ip adress>

Once on the GCP host, the SecureDrop source is in ``/home/sdci/securedrop-source``
and you may activate the virtualenv, list the molecule instances and connect to
VM instances:

.. code:: sh

    cd securedrop-source
    source .venv/bin/activate
    molecule list
    molecule login -s libvirt-staging-focal --host app-staging
