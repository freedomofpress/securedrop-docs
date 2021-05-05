Release Management
==================

The **Release Manager** is responsible for shepherding the release process to
successful completion. This document describes their responsibilities. Some items
must be done by people that have special privileges to do specific tasks
(e.g. privileges to access the production apt server),
but even if the **Release Manager** does not have those privileges, they should
coordinate with the person that does to make sure the task is completed.

In addition to the Release Manager, we typically recognize the following
roles for a SecureDrop release:

- **Deputy RM:** for additional time zone coverage, to delegate specific tasks,
  and to act as backup in case of the RM becomes unavailable for any reason.

- **Localization Manager:** to manage outreach to the translator community, and
  to coordinate translation updates of existing strings.

- **Deputy LM:** like the RM, this role is backed up by another team member.

- **Communications Manager:** to prepare and distribute pre-release and
  release messaging (including standard upgrade instructions, release notes,
  social media posts, and support portal announcements)

During the full release cycle, we also recognize the following role:

- **Community Manager:** to engage with community contributors, offer initial
  responses to new issues and Pull Requests, and follow up with other SecureDrop
  team members as appropriate.

We aim to rotate membership in these roles regularly.

Pre-Release
-----------

1. Open a **Release SecureDrop <major>.<minor>.<patch>** issue to track release-related activity.
   Keep this issue updated as you proceed through the release process for transparency.

#. Copy a link of the latest release or release candidate from the `Tails apt repo
   <https://deb.tails.boum.org/dists/>`_ and include it in the issue. You can compare it with the
   `Tails release calendar <https://tails.boum.org/contribute/calendar/>`_ if you're not sure. The
   goal is to make sure we test against the lastest Tails release, including release candidates,
   so that we can report bugs early to Tails.

#. Check the Tor blog for new
   `release candidates <https://blog.torproject.org/category/tags/release-candidate>`_ and new
   `stable releases <https://blog.torproject.org/category/tags/stable-release>`_. Let the team
   know about any new release candidates during the SecureDrop release process in case there are
   critical bug fixes. For a new stable release, file an issue and upgrade Tor following these
   steps:

      a. Bump the version in `fetch-tor-packages
         <https://github.com/freedomofpress/securedrop/blob/develop/molecule/fetch-tor-packages/
         playbook.yml>`_ and open a PR.

      b. Run ``make fetch-tor-packages`` to download the new debs. The script uses
         apt under the hood, so the Release file on the Tor packages is verified according
         to Tor's signature, ensuring package integrity.

      c. Copy the downloaded packages into the ``securedrop-dev-packages-lfs`` repo,
         and open a PR so that a reviewer can verify that the checksums match the checksums
         of the packages hosted on the
         `Tor apt repo <https://deb.torproject.org/torproject.org/pool/main/>`_. Once the PR is
         merged, the packages will be resigned with our an FPF-managed test-only signing key,
         replacing the Tor signature, and served from ``apt-test.freedom.press``.

#. Create a release branch.

   For a regular release, create a release branch off of ``develop``::

     git checkout develop
     git checkout -b release/<major>.<minor>.0


   For a point release, create a release branch off of the latest merged release branch::

     git checkout release/<major>.<minor>.0
     git checkout -b release/<major>.<minor>.1

#. For each release candidate, update the version files, code repo changelog, and Debian package
   changelog.

   a. First collect a list of changes since the last release. For example, if the last release was
      version 1.6.0, you can view changes in Github by running::

         https://github.com/freedomofpress/securedrop/compare/release/1.6.0...develop

      Also check `SecureDrop milestones <https://github.com/freedomofpress/securedrop/milestones>`_
      to make sure all milestone changes are included. Append GitHub PR numbers to each
      change. You will add these changes to the changelog in the next step.

   #. Run ``update_version.sh`` which will walk you though updating the version files and
      changelogs. When you run the script, pass it the new version in the format
      ``<major>.<minor>.<patch>~rcN``::

        ./update_version.sh <major>.<minor>.<patch>~rcN

      .. note:: A tilde is used in the version number passed to ``update_version.sh`` to match
                the format specified in the `Debian docs
                <https://www.debian.org/doc/manuals/maint-guide/first.en.html#namever>`_ on how to
                name and version a package, whereas a dash is used in the tag version number
                since `git does not support the use of tilde
                <https://git-scm.com/docs/git-check-ref-format#_description>`_.

      .. note:: In the Debian changelog, we typically just refer the reader to the ``changelog.md``
                file.

   #. Disregard the script-generated ``.tag`` file since this is only used when we need to sign the
      final release tag (see `Release Process`_ section).

   #. Sign the commit that was added by ``update_version.sh``::

        git commit --amend --gpg-sign

   #. Push the branch::

        git push origin release/<major>.<minor>.<patch>

   #. Push the unsigned tag (only the final release tag needs to be signed, see
      `Release Process`_ section)::

        git push origin <major>.<minor>.<patch>-rcN

   #. Once the tag is pushed, notify the Localization Manager so that the localization team can get
      started on translations.

#. Build Debian packages:

   a. Check out the tag for the release candidate.
   b. Build the packages with ``make build-debs``

     .. note:: If the :ref:`build container <build_container>` used by ``make build-debs`` has
               security updates, then you will see ``test_ensure_no_updates_avail`` fail in the
               build output. To get around the bottleneck of tight restrictions around who can
               update the build container, you can ignore this test failure until you are building a
               production release.

   c. Build logs should be saved and published according to the `build log guidelines
      <https://github.com/freedomofpress/securedrop/wiki/Build-logs>`_.
   d. Open a PR on `securedrop-dev-packages-lfs
      <https://github.com/freedomofpress/securedrop-dev-packages-lfs>`_ that targets the ``main``
      branch with the new debs. Do not include tarballs or any debs that would overwrite
      existing debs. Changes merged to this branch will be published to ``apt-test.freedom.press``
      within 15 minutes.

     .. warning:: Only commit deb packages with an incremented version number: do not clobber
                  existing packages. That is, if there is already a deb called e.g.
                  ``ossec-agent-3.6.0-amd64.deb`` in ``main``, do not commit a new version of this
                  deb.

     .. note:: If the release contains other packages not created by ``make build-debs``, such as
               Tor or kernel updates, make sure that they also get pushed to
               ``apt-test.freedom.press``.

#. Write a test plan that focuses on the new functionality introduced in the release. Post for
   feedback and make changes based on suggestions from the community. Once it's ready, publish the
   test plan in the `wiki <https://github.com/freedomofpress/securedrop/wiki>`_ and link to it in
   the **Release SecureDrop <major>.<minor>.<patch>** issue.

#. Create a new QA matrix spreadsheet by copying the google spreadsheet from the last release and
   adding a new row for testing new functionality specific to the release candidate. Link to this
   in the **Release SecureDrop <major>.<minor>.<patch>** issue.

#. At this point, QA can begin. During the QA period:

   * Encourage QA participants to QA the release on production VMs and
     hardware. They should post their QA reports in the release issue
     such that it is clear what was and what was not tested. It is the
     responsibility of the release manager to ensure that sufficient QA
     is done on the release candidate prior to final release.

   * Triage bugs as they are reported. If a bug must be fixed before the
     release, it's the release manager's responsibility to either fix it
     or find someone who can.

   * Backport release QA fixes merged into ``develop`` into the release
     branch using ``git cherry-pick -x <commit>`` to clearly indicate
     where the commit originated from.

   * At your discretion -- for example when a significant fix is merged
     -- prepare additional release candidates and have fresh Debian
     packages prepared for testing.

   * For a regular release, the string freeze will be declared by the
     translation administrator one week prior to the release. After this
     is done, ensure that no changes involving string changes are
     backported into the release branch.

   * Work with the Communications Manager assigned for the release to prepare a pre-release
     announcement that will be shared on the support.freedom.press support portal, securedrop.org
     website, and Twitter. Wait until the day of the release before including an announcmement for a
     SecureDrop security update. For a point release, you may be able to skip the pre-release
     announcement depending on how small the point release is.

     Make sure a draft of the release notes are prepared and shared for review, and that a draft PR
     is prepared into the ``securedrop-docs`` repository which:

     - bumps the SecureDrop version of the documentation using the ``update_version.sh``
       script in that repository;
     - adds upgrade instructions and other release-specific technical documentation;
     - updates the screenshots, if warranted;

Release Process
---------------

1. If this is a regular release, work with the translation administrator
   responsible for this release cycle to review and merge the final translations
   and screenshots (if necessary) they prepare. Refer to the
   :ref:`i18n documentation <i18n_release>` for more information about the i18n
   release process. Note that you *must* manually inspect each line in the diff
   to ensure no malicious content is introduced.
#. Prepare the final release commit and tag. Do not push the tag file.
#. Step through the signing ceremony for the tag file. If you do not
   have permissions to do so, coordinate with someone that does.
#. Once the tag is signed, append the detached signature to the unsigned tag::

    cat 1.x.y.tag.sig >> 1.x.y.tag

#. Delete the original unsigned tag::

    git tag -d 1.x.y

#. Make the signed tag::

    git mktag < 1.x.y.tag > .git/refs/tags/1.x.y

#. Verify the signed tag::

    git tag -v 1.x.y

#. Push the signed tag::

    git push origin 1.x.y

#. Ensure there are no local changes (whether tracked, untracked or git ignored)
   prior to building the debs. If you did not freshly clone the repository, you
   can use git clean:

   Dry run (it will list the files/folders that will be deleted)::

      git clean -ndfx

   Actually delete the files::

      git clean -dfx

#. Build Debian packages:

   a. Verify and check out the signed tag for the release.
   #. Build the packages with ``make build-debs``.
   #. Build logs should be saved and published according to the `build
      log guidelines
      <https://github.com/freedomofpress/securedrop/wiki/Build-logs>`_.
#. In a clone of the private
   `securedrop-debian-packages-lfs <https://github.com/freedomofpress/securedrop-debian-packages-lfs>`_
   repository, create a branch from ``main`` called ``release``.
#. In your local branch, commit the built packages to the ``core/focal``
   directory.

   * If the release includes a Tor update, make sure to include the
     new Tor Debian packages.
   * If the release includes a kernel update, make sure to add the
     corresponding grsecurity-patched kernel packages, including both
     ``linux-image-*`` and ``linux-firmware-image-*`` packages as
     appropriate.
#. Run the ``tools/publish`` script. This will create the ``Release`` file.
#. Commit the changes made by the ``tools/publish`` script.
#. Push your commits to the remote ``release`` branch. This will trigger an
   automatic upload of the packages to ``apt-qa.freedom.press``, but the
   packages will not yet be installable.
#. Create a `draft PR <https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests#draft-pull-requests>`__
   from ``release`` into ``main``. Make sure to include a link to the build
   logs in the PR description.
#. A reviewer must verify the build logs, obtain and sign the generated ``Release``
   file, and append the detached signature to the PR. The PR should remain in
   draft mode. The packages on ``apt-qa.freedom.press`` are now installable.
#. Coordinate with one or more team members to confirm a successful
   clean install in production VMs using the packages on
   ``apt-qa.freedom.press``.
#. If no issues are discovered in final QA, promote the packaging PR out of draft
   mode.
#. A reviewer must merge the packaging PR. This will publish the packages on
   ``apt.freedom.press``.
#. The reviewer must delete the ``release`` branch so that it can be re-created
   during the next release.
#. Update the `public documentation <https://docs.securedrop.org/>`_:

  * Review and merge the ``securedrop-docs`` PR that bumps the version and adds
    the upgrade documentation for this release.

  * Verify that there are no changes on the ``main`` branch of ``securedrop-docs``
    that should not be released into the stable version of the documentation.

    If necessary, you can create a branch from an earlier commit. Follow the
    ``release/<major>.<minor>.<patch>`` convention for the branch name in
    ``securedrop-docs``, and cherry-pick at least the changes from the PR above
    onto it via a backport PR.

  * Create a tag signed with your developer key in the format
    ``<major>.<minor>.<patch>`` on the ``HEAD`` of the ``main`` branch or of the
    docs release branch you created in the previous step. ::

      git tag -as <major>.<minor>.<patch>
      git push origin <major>.<minor>.<patch>

    This will update the stable version of the documentation.

  * Subsequent changes to the stable version should be tagged with PEP-440
    conformant `post-release separators <https://www.python.org/dev/peps/pep-0440/#post-release-separators>`__
    in the format ``<major>.<minor>.<patch>-1``,  ``<major>.<minor>.<patch>-2``,
    and so on.

#. Verify that the public documentation has been updated, by checking the
   `ReadTheDocs build history <https://readthedocs.org/projects/securedrop/builds/>`_.
   If necessary, restart the build.
#. Create a `release
   <https://github.com/freedomofpress/securedrop/releases>`_ on GitHub
   with a brief summary of the changes in this release.
#. Make sure that release notes are written and posted on the SecureDrop blog.
#. Make sure that the release is announced from the SecureDrop Twitter account.
#. Make sure that members of `the support portal
   <https://support.freedom.press>`_ are notified about the release.
#. Make sure that version string monitored by FPF's Icinga monitoring system
   is updated by the infrastructure team.
#. Update the upgrade testing boxes following this process:
   :ref:`updating_upgrade_boxes`.

Post-Release
------------

1. Backport the changelog from the release branch into ``develop``.

   a. Collect the hashes of all the commits that modified ``changelog.md`` during the release::

         git log --pretty=oneline changelog.md

   #. From a new branch based on ``develop``, cherry-pick each commit in the ``git log`` output
      from the previous step. Make sure to use the ``-x`` flag so that the original commit is
      appended to the new commit.

#. Bump the SecureDrop version so that it's ready for the next release.

   a. Create a new minor release candidate. Only add a commit message and accept the default changes
      for everything else (it's fine to leave the changelog entries with empty bullets). For
      example, if the release is 1.3.0, then you'll run::

         ./update_version.sh 1.4.0~rc1

   #. Disregard the script-generated ``.tag`` file since this is only used when we are making an
      actual release.

   #. Sign the commit that was added by ``update_version.sh``::

         git commit --amend --gpg-sign

   #. Make a PR to merge these changes into ``develop``.

#. Monitor the `FPF support portal <https://support.freedom.press>`_ and the
   `SecureDrop community support forum <https://forum.securedrop.org/c/support>`_ for any new user
   issues related to the release.
