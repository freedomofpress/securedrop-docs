.. _AnalyzingAlerts:

Analyzing the alerts
--------------------

Understanding the contents of the OSSEC alerts requires a background and
knowledge in Linux systems administration. They may be confusing, and at
first it will be hard to tell between a genuine problem and a fluke. You
should examine these alerts regularly to ensure that the SecureDrop
environment has not been compromised in any way, and follow up on any
particularly concerning messages with direct investigation.

An initial SecureDrop install will generate quite a few alerts as OSSEC is installed
early in the install process.
As part of the administration of a SecureDrop instance, regularly looking through
the generated alerts provides administrators with information on the overall health of
the SecureDrop instance.

OSSEC alerts will range from a severity level of 1 (lowest) to 14 (highest), and as a baseline, you
should expect to see the following alerts:

Common OSSEC alerts
~~~~~~~~~~~~~~~~~~~

Package updates
^^^^^^^^^^^^^^^
The SecureDrop *Application* and *Monitor Servers* check for package updates every day.
As updates are automatically installed, OSSEC will notice and send out alerts. You
may see any number of these alerts in the email, as several alerts can be batched in
a single email. You should also see them in an email named ``Daily Report: File Changes``.
To verify this activity matches the package history, you can review the logs in
``/var/log/apt/history.log``. ::

    Received From: (app)
    Rule: 2902 fired (level 7) -> "New dpkg (Debian Package) installed."
    Portion of the log(s):

    status installed <package name> <version>

In addition to letting you know what packages were updated, OSSEC will send alerts
about the specific changes to the files in these packages. ::

    Received From: (app)
    Rule: 550 fired (level 7) -> "Integrity checksum changed."
    Portion of the log(s):

    Integrity checksum changed for: '/usr/sbin/<binary name>'
    Old md5sum was: '<old md5sum>'
    New md5sum is : '<new md5sum>'
    Old sha1sum was: '<old sha1sum>'
    New sha1sum is : '<new sha1sum>'

It may seem redundant to receive both ``New dpkg (Debian Package) installed``
and ``Integrity checksum changed`` alerts.  This happens because OSSEC's alerts
do not track root causation: OSSEC doesn't "know" that files have changed
because new packages have been installed or updated, so it reports both sets of
events independently.  As a result, these clusters of alerts are normal and
expected: they tell you that your SecureDrop servers are properly up-to-date
and patched.

Keep an eye out for *exceptions* to this rule as you analyze your OSSEC alerts.
Surprising changes to configuration files, or new or changed files unrelated to
the daily updates, may warrant further investigation.

Occasionally your SecureDrop Servers will send an alert for failing to connect
to Tor relays. Since SecureDrop runs as a Tor Onion Service, it is possible
for Tor connections to timeout or become overloaded. ::

    Received From: (app)
    Rule: 1002 fired (level 2) -> "Unknown problem somewhere in the system."
    Portion of the log(s):

    [warn] Your Guard <name> ($fingerprint) is failing a very large amount of
    circuits. Most likely this means the Tor network is overloaded, but it
    could also mean an attack against you or potentially the guard itself.

This alert is common but if you see them for sustained periods of time (several
times a day), please :doc:`contact us</introduction/getting_support>` for help.

Daily reports
^^^^^^^^^^^^^

On days where file integrity checksums have changed or users have logged into ``app``
or ``mon`` servers, you will receive emails entitled ``Daily report: File changes`` or
``Daily report: Successful logins``. These emails may be a more convenient format
should you not have continuous access to the inbox or GPG key.

**Action**: periodically review these daily reports to ensure file changes correspond
to platform updates and logins correspond to authorized admin activity on the SecureDrop
servers.

If you have any suggestions on how to further tune or improve the alerting,
you can open an issue on `GitHub <https://github.com/freedomofpress/securedrop/labels/goals%3A%20reduce%20IDS%20noise>`__.

Uncommon OSSEC alerts
~~~~~~~~~~~~~~~~~~~~~

Data integrity
^^^^^^^^^^^^^^

SecureDrop runs automatic checks for submission data integrity
problems. For example, secure deletion of large submissions could
potentially be interrupted: ::

    Received From: (app) 10.20.2.2->/opt/venvs/securedrop-app-code/bin/python3 /var/www/securedrop/manage.py check-disconnected-fs-submissions
    Rule: 400801 fired (level 1) -> "Indicates that there are files in the submission area without corresponding submissions in the database."
    Portion of the log(s):

    ossec: output: '/opt/venvs/securedrop-app-code/bin/python3 /var/www/securedrop/manage.py check-disconnected-fs-submissions': There are files in the submission area with no corresponding records in the database. Run "manage.py list-disconnected-fs-submissions" for details.

To resolve the issue, you can :ref:`clean them up <submission-cleanup>`.

Instance misconfigurations
^^^^^^^^^^^^^^^^^^^^^^^^^^
In addition, SecureDrop performs a small set of daily configuration checks to ensure
that the iptables rules configured on the *Application* and *Monitor Server* match
the expected configuration. If they do not, you may receive a level 12 alert
like the following: ::

      Received From: (app) 10.20.2.2->/var/ossec/checksdconfig.py
      Rule: 400900 fired (level 12) ->
      "Indicates a problem with the configuration of the SecureDrop servers."
      Portion of the log(s):
      ossec: output: '/var/ossec/checksdconfig.py': System configuration error:
      The iptables default drop rules are incorrect.

Alternatively, the error text may say: ``The iptables rules have not been configured.``
To resolve the issue, you can reinstate the standard iptables
rules by :ref:`updating the system configuration <update-system-configuration>`.

``securedrop-admin`` commands
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OSSEC will send an alert when the `securedrop-admin` tool is used to backup, restore, or change the system configuration: ::

    Rule: 400001 fired (level 13) -> "Ansible playbook run on server (securedrop-admin install, backup, or restore)."

**Action**: You should ensure that this action was performed by you or a fellow administrator.

If you believe that the system is behaving abnormally, you should
:doc:`contact us</introduction/getting_support>` for
help.
