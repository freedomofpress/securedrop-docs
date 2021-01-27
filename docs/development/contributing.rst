Contributing to SecureDrop
==========================

Thank you for your interest in contributing to SecureDrop! We welcome both new
and experienced open-source contributors and are committed to making it as easy
as possible to contribute. Whether you have a few minutes or many hours, there
are a variety of ways to help. We are always looking for help from:

* `Programmers`_, to help us develop SecureDrop;
* `Technical writers`_, to help improve the documentation;
* `UX contributors`_, to help improve the product experience for end users;
* `Translators`_, to translate SecureDrop;
* `Release managers`_, to create and maintain Debian GNU/Linux packages and repositories;
* `Forum moderators and support`_ volunteers, to help with the support forums.

You can always find a regular project contributor to answer any questions you
may have on the `SecureDrop instant messaging channel
<https://gitter.im/freedomofpress/securedrop>`__. You can also register on `the
forum <https://forum.securedrop.org/>`__ for more information and to
participate in longer discussions.


.. note::

   The SecureDrop GitHub repositories and other project resources are managed
   by `Freedom of the Press Foundation employees <https://freedom.press/about/staff>`__.
   All SecureDrop contributors are required to abide by the project's `Code of Conduct <https://github.com/freedomofpress/securedrop/blob/develop/CODE_OF_CONDUCT.md>`__.


* To start contributing to the `codebase <https://github.com/freedomofpress>`__, see our :doc:`contributing guidelines <contributor_guidelines>`.
* To start making documentation changes, see our :doc:`documentation guidelines <documentation_guidelines>`.
* To start translating, see our :doc:`translator guide <translations>`.
* Not sure where to start? You can always ask for advice in the `chat room <https://gitter.im/freedomofpress/securedrop>`__.

Programmers
~~~~~~~~~~~
The SecureDrop system includes `Flask`_-based web applications for sources and
journalists. It is deployed across multiple machines with `Ansible`_. Most of
SecureDrop's code is written in `Python`_.

.. _`Flask`: https://flask.palletsprojects.com/
.. _`Ansible`: https://github.com/ansible/ansible
.. _`Python`: https://github.com/freedomofpress/securedrop/search?l=python


A contributing programmer can work on either newcomer or advanced developer
issues.

Newcomer Issues
---------------
If you are a novice programmer, you can start with these issues in the following
repositories:

- `SecureDrop <https://github.com/freedomofpress/securedrop/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22>`__
- `SecureDrop Workstation <https://github.com/freedomofpress/securedrop-workstation/labels/good%20first%20issue>`__
- `SecureDrop Client <https://github.com/freedomofpress/securedrop-client/labels/good%20first%20issue>`__


Advanced Issues
---------------
Programmers who are more comfortable with contributing to the SecureDrop codebase
can work on issues related to the following topics:

**Application development and general tasks:**

* `Application code cleanup <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+app+code+cleanup%22>`__
* `Developer workflow <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+improve+developer+workflow%22>`__
* `Needs/Research <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3Aneeds%2Fresearch+>`__
* `Source and journalist applications <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3Aapp>`__
* `Journalist experience <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+journalist+experience%22>`__
* `Source experience <https://github.com/freedomofpress/securedrop/labels/goals%3A%20improve%20source%20experience>`__
* `Tests <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+more+tests%22>`__


**Infrastructure focus:**

* `Continuous Integration <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+sick+CI%22>`__
* `Ansible logic/installation <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+Improve+Ansible+logic+%2F+smoother+install%22>`__
* `Operations and deployment <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3Aops%2Fdeployment>`__


**Security focus:**

* `IDS noise <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3A%22goals%3A+reduce+IDS+noise%22>`__
* `OSSEC <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3AOSSEC>`__
* `Security <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+sort%3Acreated-desc+label%3Asecurity>`__

You may also want to consider contributing to the new `SecureDrop Workstation <https://github.com/freedomofpress/securedrop-workstation/>`__
project and its components, including the graphical `SecureDrop Client <https://github.com/freedomofpress/securedrop-client/>`__ app.


Preparing and submitting changes
--------------------------------
Before beginning your work on any given issue, we recommend asking questions
or sharing an implementation proposal on the relevant GitHub issue.
Alternatively, you can often find the development team on `Gitter chat <https://gitter.im/freedomofpress/securedrop>`__.
Communicating early and often is especially important for larger changes.

When you're ready to share your work with the SecureDrop team for review, submit
a `pull request
<https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests>`__
with the proposed changes. :doc:`Tests <testing_securedrop>` will run
automatically on GitHub.

If you would like to contribute on a regular basis, you'll want to read the
:doc:`developer documentation <setup_development>` and set up a local
development environment to preview changes, run tests locally, etc.

Technical Writers
~~~~~~~~~~~~~~~~~

Technical writers and editors are invited to review the `documentation
<https://docs.securedrop.org/>`__ and fix any mistakes in accordance with the
:doc:`documentation guidelines <documentation_guidelines>`. Our documentation code is
located in our `documentation repository <https://github.com/freedomofpress/securedrop-docs>`__.

If this is your first time contributing to SecureDrop documentation, consider
working on low-hanging fruit to become familiar with the process.


If you would like to contribute to copywriting user-facing text in the SecureDrop UI,
see `these issues <https://github.com/freedomofpress/securedrop-ux/labels/NeedsCopywriting>`__
in `our separate User Experience repo <https://github.com/freedomofpress/securedrop-ux/>`__.



UX Contributors
~~~~~~~~~~~~~~~

If you have interaction or visual design skills, UI copywriting skills, or
user research skills, check out our `User Experience repository <https://github.com/freedomofpress/securedrop-ux/>`__.
It includes a wiki with notes from UX meetings, design standards, design
principles, links to past research synthesis efforts, and ongoing and past
work documented in the form of issues.

If you have front-end development skills, take a look at these issues in the
primary SecureDrop repository in GitHub:

* `All issues labeled "UX" <https://github.com/freedomofpress/securedrop/issues?q=is%3Aopen+is%3Aissue+label%3AUX>`__
* `CSS/SASS <https://github.com/freedomofpress/securedrop/issues?q=is%3Aopen+is%3Aissue+label%3ACSS%2FSASS>`__ and `HTML <https://github.com/freedomofpress/securedrop/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+label%3AHTML>`__
* `All issues labeled "Journalist Experience" <https://github.com/freedomofpress/securedrop/issues?q=is%3Aopen+is%3Aissue+label%3A%22goals%3A+journalist+experience%22>`__



Release Managers
~~~~~~~~~~~~~~~~

All software deployed with SecureDrop is installed via Debian GNU/Linux packages
via Ansible. The `primary repository <https://apt.freedom.press/>`__ is
controlled, maintained, and signed by `Freedom of the Press Foundation employees
<https://freedom.press/about/staff>`__. The current responsibilities of the release manager
are covered in :doc:`detailed documentation <release_management>`.

If you are a `Debian developer <https://www.debian.org/devel/>`__ you can help
improve packaging and the release process:

* `Building SecureDrop application and OSSEC packages <https://github.com/freedomofpress/securedrop/tree/develop/molecule/builder-xenial>`__ and `pending bugs and tasks <https://github.com/freedomofpress/securedrop/issues?q=is%3Aissue+is%3Aopen+package+label%3A%22goals%3A+packaging%22>`__
* Building `grsecurity kernels <https://github.com/freedomofpress/ansible-role-grsecurity>`__ and `pending bugs and tasks <https://github.com/freedomofpress/ansible-role-grsecurity/issues>`__



Translators
~~~~~~~~~~~

Translating SecureDrop is crucial to making it useful for
investigative journalism around the world. If you know English and
another language, we would welcome your help.

SecureDrop is translated using `Weblate
<https://weblate.securedrop.org/>`__. We provide a :doc:`detailed
guide <translations>` for translators, and feel free to contact us in the
`translation section of the SecureDrop forum
<https://forum.securedrop.org/c/translations>`__ for help. Non-English
forum discussions are also welcome.

|SecureDrop translation status|

|SecureDrop language status|

.. |SecureDrop translation status| image:: https://weblate.securedrop.org/widgets/securedrop/-/287x66-white.png
   :alt: SecureDrop translation status

.. |SecureDrop language status| image:: https://weblate.securedrop.org/widgets/securedrop/-/horizontal-auto.svg
   :alt: SecureDrop language status



Forum Moderators and Support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those running a production instance of SecureDrop are encouraged to `read the
support documentation <https://support-docs.securedrop.org/>`__ to get
help from the `Freedom of the Press Foundation <https://freedom.press>`__. For
less sensitive topics such as running a demo or getting help to understand a
concept, a `public forum section <https://forum.securedrop.org/c/support>`__ is
better suited. To assist on the forum:

* Look for `the latest unanswered questions in the
  <https://forum.securedrop.org/c/support>`__ forum and answer them.
* If you find questions `elsewhere in the forum
  <https://forum.securedrop.org>`__ that have a better chance at
  getting an answer in the `support section
  <https://forum.securedrop.org/c/support>`__, suggest in Gitter
  to move topics from a category to another.
