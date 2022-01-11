.. _updating_ossec_rules:

Updating OSSEC Rules
====================

SecureDrop uses the OSSEC open source host-based intrusion detection system
(IDS) for log analysis, file integrity checking, policy monitoring, rootkit
detection and real-time alerting. Refer to our :ref:`OSSEC guide <ossec_guide>`
to learn more about how SecureDrop admins set up and monitor OSSEC alerts.

Alerting Strategy
-----------------

The goals of the OSSEC alerts in SecureDrop is to notify admins of:

1. Suspicious security events
2. Changes that require some kind of admin action
3. Other important notifications regarding system state.

If an alert is purely informational and there is no realistic action an
admin is expected to take, you should think carefully before
suggesting a rule for it. Each additional alert that admins must read and/or
respond to takes time. Alerts that are unimportant or otherwise require no action
can lead to alert fatigue and thus to critical alerts being ignored.

.. _using_ossec_logtest :

Using ``ossec-logtest``
-----------------------

Development on the OSSEC rules should be done from the staging environment.

On ``mon-staging``, there is a utility installed as part of OSSEC called
``ossec-logtest`` that you can use to test log events. In order to evaluate
whether an alert will be produced, and if so, what rule triggered it and its
level, you can simply pass the event to ``ossec-logtest``:

.. code:: sh

  root@mon-staging:/home/vagrant# sudo echo "Feb 10 23:34:40 app-prod kernel: [  124.188641] grsec: denied RWX mmap of <anonymous mapping> by /usr/sbin/apache2[apache2:1328] uid/euid:33/33 gid/egid:33/33, parent /usr/sbin/apache2[apache2:1309] uid/euid:0/0 gid/egid:0/0" | /var/ossec/bin/ossec-logtest
  2017/08/16 22:28:25 ossec-testrule: INFO: Reading local decoder file.
  2017/08/16 22:28:25 ossec-testrule: INFO: Started (pid: 18973).
  ossec-testrule: Type one log per line.

  **Phase 1: Completed pre-decoding.
         full event: 'Feb 10 23:34:40 app-prod kernel: [  124.188641] grsec: denied RWX mmap of <anonymous mapping> by /usr/sbin/apache2[apache2:1328] uid/euid:33/33 gid/egid:33/33, parent /usr/sbin/apache2[apache2:1309] uid/euid:0/0 gid/egid:0/0'
         hostname: 'app-prod'
         program_name: 'kernel'
         log: '[  124.188641] grsec: denied RWX mmap of <anonymous mapping> by /usr/sbin/apache2[apache2:1328] uid/euid:33/33 gid/egid:33/33, parent /usr/sbin/apache2[apache2:1309] uid/euid:0/0 gid/egid:0/0'

  **Phase 2: Completed decoding.
         decoder: 'iptables'

  **Phase 3: Completed filtering (rules).
         Rule id: '100101'
         Level: '7'
         Description: 'grsec error was detected'
  **Alert to be generated.

This is the utility we use in automated tests of OSSEC.

.. _writing_automated_tests_for_ossec_rules :

Writing Automated Tests for OSSEC Rules
---------------------------------------

We strongly recommend before making changes to OSSEC rules to attempt to write
a failing test which you then can make pass with a patch to the OSSEC rules:

1. Identify a log event you can use to trigger the alert.

.. warning:: Be sure to use only log events from test SecureDrop instances or
             those you have verified do not contain any sensitive data.

2. Write a Testinfra_ test to verify that the log event does or does not trigger
   an alert.
3. Apply your patch to the OSSEC rule on the relevant VM (likely ``app``).
4. Restart the service via ``sudo service ossec restart`` on ``mon``.

.. note:: Currently we only have automated tests for alerts triggered due to
          log events (for example not for `syscheck`_, OSSEC's integrity
          checking process). If you have ideas for additional automated test
          coverage of alerts, please suggest them in ticket `2134`_ on GitHub.

.. _Testinfra: https://testinfra.readthedocs.io/en/latest/
.. _syscheck: https://ossec-docs.readthedocs.io/en/latest/docs/manual/syscheck/index.html
.. _2134: https://github.com/freedomofpress/securedrop/issues/2134


How to add a new OSSEC rule?
=============================

OSSEC processes events in two steps:

1. `Decoders <https://ossec-documentation.readthedocs.io/en/latest/manual/lids/decoders.html>`_
   parse and filter log events that meet certain criteria for subsequent processing.
   SecureDrop's custom rules are defined in
   ``install_files/securedrop-ossec-server/var/ossec/rules/local_rules.xml``.

2. `Rules <https://ossec-documentation.readthedocs.io/en/latest/manual/lids/rules.html>`_
   check decoded events against conditions and optionally yield alerts.
   SecureDrop's custom rules are defined in
   ``install_files/securedrop-ossec-server/var/ossec/etc/local_decoder.xml``.

A basic decoder filters log events by ``program_name`` (e.g., ``fwupd``).
If a decoder is already defined for the program of interest, you can go straight
to :ref:`defining a new rule <the_rules>` unless you have a reason to add additional
:ref:`decoders <the_decoder_file>` for further filtering.


.. _the_decoder_file:

The decoder file
-----------------

For example, to add a decoder for log events from ``fwupd``, you can add to
``local_decoder.xml``:

::

    <!--
      The default fwupd tries to auto-update and generates error.
    -->
    <decoder name="fwupd">
      <program_name>fwupd</program_name>
    </decoder>

You can find this ``program_name`` value using the :ref:`"ossec-logtest" command
<using_ossec_logtest>`.  Copy-paste the log event as input to this command, and
it will give you some parsed output:

..
    Warning to editors:  The instances of "â€œ" in this example come verbatim
    from actual OSSEC alerts reported (and reproduced) in
    freedomofpress/securedrop#5835.  Whether or not they should be considered
    invalid *output* from OSSEC, they are valid *input* for the purpose of this
    example and documentation.  See
    <https://github.com/freedomofpress/securedrop-docs/pull/199#pullrequestreview-634460996>
    for a prior discussion on this point.

::

    $ echo "Mar  1 13:22:53 app fwupd[133921]: 13:22:53:0883 FuPluginUefi         Error opening directory â€œ/sys/firmware/efi/esrt/entriesâ€�: No such file or directory" | sudo /var/ossec/bin/ossec-logtest
    [...]
    **Phase 1: Completed pre-decoding.
        full event: 'Mar  1 13:22:53 app fwupd[133921]: 13:22:53:0883 FuPluginUefi         Error opening directory â€œ/sys/firmware/efi/esrt/entriesâ€�: No such file or directory'
        hostname: 'app'
        program_name: 'fwupd'
        log: '13:22:53:0883 FuPluginUefi         Error opening directory â€œ/sys/firmware/efi/esrt/entriesâ€�: No such file or directory'

    **Phase 2: Completed decoding.
        No decoder matched.

    **Phase 3: Completed filtering (rules).
        Rule id: '1002'
        Level: '2'
        Description: 'Unknown problem somewhere in the system.'
    **Alert to be generated.

.. _the_rules:

The rules
---------

Next, you can add one or more rules corresponding to the new decoder, making
sure that the rules have proper unique `id` numbers and are written in the
correct (sorted) place in the ``local_rules.xml`` file.


::

    <group name="fwupd">
    <rule id="100111" level="0">
        <decoded_as>fwupd</decoded_as>
        <match>Error opening directory</match>
        <description>fwupd error</description>
        <options>no_email_alert</options>
    </rule>
    <rule id="100112" level="0">
        <decoded_as>fwupd</decoded_as>
        <match>Failed to load SMBIOS</match>
        <description>fwupd error for auto updates</description>
        <options>no_email_alert</options>
    </rule>
    </group>


Verify the new OSSEC rule
-------------------------

On the monitor server you can use the following command as `root` to verify
the new rule:

::

    /var/ossec/bin/ossec-analysisd -t

``ossec-analysisd`` will receive log messages and compare them to our rules,
including the new rule you just added. Then it creates alerts when a log message
matches an applicable rule.


Adding an automated test for staging
-------------------------------------

You can then add tests in the ``molecule/testinfra/mon/test_ossec_ruleset.py``
file. Here the test loops over the entries in the
``log_events_with_ossec_alerts`` and ``log_events_without_ossec_alerts``
variables in ``molecule/testinfra/vars/staging.yml`` and makes sure that the
``rule_id`` and ``level`` match.  See :ref:`writing_automated_tests_for_ossec_rules`
for details.



Deployment
----------

The OSSEC rules and associated configuration files are distributed via Debian
packages maintained by Freedom of the Press Foundation. Any changes made to OSSEC
configuration files will land on production SecureDrop monitoring servers as
part of each SecureDrop release. This upgrade will occur automatically.

.. note:: The use of automatic upgrades for release deployment means that any
          changes made locally by admins to their OSSEC rules will not
          persist after a SecureDrop update.
