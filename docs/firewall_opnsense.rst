.. _firewall_opnsense:

Setting Up An OPNSense Network Firewall
=======================================

Before You Begin
----------------
First, consider how the firewall will be connected to the Internet. You
will need to provision several unique subnets, which should not conflict
with the network configuration on the WAN interface. If you are unsure,
consult your local system administrator.

Many firewalls, including the recommended OPNSense device,
automatically set up the LAN interface on ``192.168.1.1/24``. This
particular private network is also a very common choice for home and
office routers. If you are connecting the firewall to a router with the
same subnet (common in a small office, home, or testing environment),
you will probably be unable to connect to the network at first. However,
you will be able to connect from the LAN to the firewall's Web GUI,
and from there you will be able to configure the network so it is working correctly.

The recommended TekLager APU4D4 has 4 NICs: WAN, LAN,
OPT1, and OPT2. This allows for a dedicated port on the network
firewall for each component of SecureDrop (*Application Server*,
*Monitor Server*, and *Admin Workstation*).

Depending on your network configuration, you should define the following
values before continuing.

.. raw:: html

   <!-- -->

-  Admin Subnet: ``10.20.1.0/24``
-  Admin Gateway: ``10.20.1.1``
-  Admin Workstation: ``10.20.1.2``

.. raw:: html

   <!-- -->

-  Application Subnet: ``10.20.2.0/24``
-  Application Gateway: ``10.20.2.1``
-  Application Server (OPT1): ``10.20.2.2``

.. raw:: html

   <!-- -->

-  Monitor Subnet: ``10.20.3.0/24``
-  Monitor Gateway: ``10.20.3.1``
-  Monitor Server (OPT2) : ``10.20.3.2``

Initial Configuration
---------------------

Unpack the firewall, connect the power, and power on the device.

We will use the OPNSense Web GUI to do the initial configuration of the
network firewall.

Connect to the OPNSense Web GUI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. If you have not already done so, boot the *Admin Workstation* into
   Tails using its designated USB drive. Make sure to enable the unsafe browser
   on the "Welcome to Tails" screen under "Additional settings".

#. Connect the *Admin Workstation* to the LAN interface. You should see
   a popup notification in Tails that says "Connection Established". If you click
   on the network icon in the upper right of the Tails Desktop, you should see
   "Wired Connected":

   |Wired Connected|

   .. warning:: Make sure your *only* active connection is the one you
      just established with the network firewall. If you are
      connected to another network at the same time (e.g. a
      wireless network), you may encounter problems trying
      to connect the firewall's Web GUI.

#. Launch the **Unsafe Browser** from the menu bar: **Applications ▸ Internet ▸
   Unsafe Browser**.

   |Launching the Unsafe Browser|

   .. note:: The *Unsafe Browser* is, as the name suggests, **unsafe**
        (its traffic is not routed through Tor). However, it is
        the only option because Tails intentionally disables LAN
        access in the **Tor Browser**.

#. A dialog will ask "Do you really want to launch the Unsafe
   Browser?". Click **Launch**.

   |You really want to launch the Unsafe Browser|

#. You will see a pop-up notification that says "Starting the Unsafe
   Browser..."

   |Pop-up notification|

#. After a few seconds, the Unsafe Browser should launch. The window
   has a bright red border to remind you to be careful when using
   it. You should close it once you're done configuring the firewall
   and use Tor Browser for any other web browsing you might do on
   the *Admin Workstation*.

   |Unsafe Browser Homepage|

#. Navigate to the OPNSense Web GUI in the *Unsafe Browser*:
   ``https://192.168.1.1``

   .. note:: If you have trouble connecting, go to your network settings and
      make sure that you have an IPv4 address in the ``192.168.1.1/24`` range.
      You may need to turn on DHCP, else you can manually configure a static
      IPv4 address of ``192.168.1.x`` with a subnet mask of ``255.255.255.0``.
      However, make sure not to configure your Tails device to have the same IP
      as the firewall (``192.168.1.1``).

#. The firewall uses a self-signed certificate, so you will see a "This
   Connection Is Untrusted" warning when you connect. This is expected.
   You can safely continue by clicking **Advanced** and **Accept the Risk and
   Continue**.

   |OPNSense - Your Connection is Insecure|

#. You should see the login page for the OPNSense GUI. Log in with the
   default username and passphrase (``root`` / ``opnsense``).

   |OPNSENSE - Default Login|

If this is your first time logging in to the firewall, the setup wizard will be
displayed. You should not step through it at this point, however, as there are
other tasks to complete. To exit, click the OPNSense logo in the top left corner
of the screen.

Set a Strong Password
~~~~~~~~~~~~~~~~~~~~~

Navigate to **System > Access > Users** and click the edit button for the ``root``
user. On the subsequent page, set a strong admin password. We recomend generating
a strong passphrase with KeePassXC and saving it in the Tails Persistent folder using
the provided KeePassXC database template. Two-factor authentication will be enabled 
in a later step.

Set Alternate Hostnames
~~~~~~~~~~~~~~~~~~~~~~~

Before you can set up the hardware firewall, you will need to set the
**Alternate Hostnames** setting.

First, navigate to **System > Settings > Administration**.  In the **Web GUI** section,
update the **Alternate Hostnames** field with the values ``192.168.1.1`` and the
IP address of the *Admin Gateway* (``10.20.1.1`` if you are using the recommended
default values), separated by a space.

   |OPNSense - alternate hostnames|

Finally, scroll to the bottom of the page and click **Save**.

Configure Interfaces Via The Setup Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To start the OPNSense Setup Wizard, navigate to **System > Wizard** and click
**Next**.


#. **General Information**: Leave your hostname as the default, ``OPNsense``.
   There is no relevant domain for SecureDrop, so we
   recommend setting this to ``securedrop.local`` or something similar. Use
   your preferred DNS servers. If you don't know what DNS servers to use,
   we recommend using Google's DNS servers: ``8.8.8.8`` and ``8.8.4.4``.
   Uncheck the **Override DNS** checkbox.

   In the **Unbound DNS** section, uncheck **Enable Resolver**.

   Click **Next**.

   |OPNSense General Info|

#. **Time Server Information**: Leave the default settings unchanged and  click **Next**.

#. **Configure WAN Interface**: Enter the appropriate configuration for
   your network. Consult your local sysadmin if you are unsure what to
   enter here. For many environments, the default of DHCP will work and the
   rest of the fields can be left at their default values.

   Click **Next** to proceed.

#. **Configure LAN Interface**: Use the IP address of the *Admin Gateway*
   (``10.20.1.1``) and the subnet mask (``/24``) of the *Admin Subnet*. Click
   **Next**.

   |OPNSense: Configure LAN Interface|

#. **Set Root Password**: If the password was already reset during the 2FA setup, you
   don't need to set it again. If it was not, then set a strong password now and
   store it in the *Admin Workstation*'s KeePassXC database. Click **Next**
   to continue.

#. **Reload Configuration**: Click **Reload** to apply the changes you made in the
   Setup Wizard.

At this point, since the LAN subnet settings were changed from
their defaults, you will no longer be able to connect after reloading
the firewall and the reload will time out. This is not an
error - the firewall has reloaded and is working correctly.

To connect to the new LAN interface, unplug and reconnect your network cable to
get a new network address assigned via DHCP. Note that if you used a subnet
with fewer addresses than ``/24``, the default DHCP configuration in
OPNSense may not work. In this case, you should assign the Admin
Workstation a static IP address that is known to be in the subnet to
continue.

The Web GUI will now be available on the *Admin Gateway* IP address. Navigate
to ``https://<Admin Gateway IP>`` in the *Unsafe Browser* and log in to the ``root``
account using an OTP token and the passphrase you just set.

Once you've logged in to the Web GUI, you are ready to continue configuring
the firewall.

Connect Interfaces and Test
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that the initial configuration is completed, you can connect the WAN
port without potentially conflicting with the default LAN settings (as
explained earlier). Connect the WAN port to the external network. You
can watch the WAN entry in the Interfaces table on the OPNSense Dashboard
homepage to see as it changes from down (red arrow pointing down) to up
(green arrow pointing up). This usually takes several seconds. The WAN's
IP address will be shown once it comes up.

Finally, test connectivity to make sure you are able to connect to the
Internet through the WAN. The easiest way to do this is to open another tab in
the Unsafe Browser and visit a host that you expect to be up (e.g. ``google.com``).

Update OPNSense to the latest version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You should update OPNSense to the latest version available before proceeding
with the rest of the configuration. Navigate to **Lobby > Dashboard** and click
**Click to check for updates** to start the process, and follow any on-screen instructions
to complete the update. Note that a reboot may be required, and you may also need
to apply several updates in a row to get to the latest version.

|OPNSense - no updates|

Enable Two-Factor Authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OPNSense supports two-factor authentication (2FA) via mobile apps such as Google Authenticator
or FreeOTP. To set it up, first make sure you have a mobile device available with
your choice of 2FA app.

Next, in the OPNSense Web GUI, navigate to **System > Access > Servers** and
click **+** to add a new server.

|OPNSense - auth server|

.. note:: The time on your firewall must be set correctly for 2FA to work properly.
    This should happen automatically once the WAN connection is established.

On the next page, enter ``TOTP Local`` in the **Descriptive name** field and choose
``Local + Timebased One Time Password`` from the **Type** dropdown. Leave the other
fields at their default values and click **Save**

Next, navigate to **System > Access > Users** and click the edit button for the ``root``
user. Scroll down the page to the **OTP seed** section and check the 
**Generate new secret (160bit)** checkbox. Finally, click **Save**.

|OPNSense - otpcheck|

Once the page has reloaded, scroll down to the **OTP QR code** section and click
**Click to unhide**, then scan the generated QR code with your mobile auth application
of choice.

|OPNSense - qrscan|

If you wish, you may also save the OTP seed value displayed above the QR code in
your Tails KeePassXC database - this isn't required, but will allow you to set up TOTP
on another mobile device if you need to in the future.

Test your new login credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To verify that your new password and OTP secret are working, navigate to **System >
Access > Tester**. Select ``TOTP Local`` from the **Authentication Server** dropdown,
enter the ``root`` username in the **Username** field, and enter your OTP token and 
password concatenated like ``123456PASSWORD`` in the **Password** field.
Then click **Test**.

|OPNSense - testuserhappy|

If the test fails, make sure you have used the correct OTP code and password, and
edit the ``root`` user record as necessary.

.. note:: You must enter the OTP token and passphrase concatenated as a single
    string like ``123456PASSWORD`` in the **Password** field.

.. warning:: Do not skip this test, or proceed further until it passes, as you
  will be locked out of the firewall Web GUI and console if the account is not
  set up correctly!

Finally,  navigate to **System > Settings > Administration** and scroll down to the
**Authentication** section at the bottom of the page. In the **Server** dropdown,
select ``TOTP Local`` and deselect ``Local Database.``. Click **Save**.

   |OPNSense - totp server|


Disable DHCP on the Firewall
----------------------------

OPNSense runs a DHCP server on the LAN interface by default. At this
stage in the documentation, the *Admin Workstation* likely has an IP address
assigned via that DHCP server.

In order to tighten the firewall rules as much as possible, we recommend
disabling the DHCP server and assigning a static IP address to the Admin
Workstation instead.

Disable DHCP Server on the LAN Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To disable DHCP, navigate to **Services > DHCPv4 > [LAN]** in the Web GUI.
Uncheck the **Enable DHCP server on the LAN interface** checkbox, scroll down,
and click **Save**.

|OPNSense - Disable DHCP|

Assign a Static IP Address to the *Admin Workstation*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now you will need to assign a static IP to the *Admin Workstation*.

You can easily check your current IP address by *clicking* the top right of
the menu bar, clicking on the **Wired Connection** and then clicking **Wired
Settings**.

|Wired Settings|

From here you can click on the cog beside the wired network connection:

|Tails Network Settings|

This will take you to the network settings. Change to the **IPv4** tab. Ensure
that **IPv4 Method** is set to **Manual**, and that the **Automatic** switch for
**DNS** is in the "off" position, as highlighted in the screenshot below:

|Tails Manual Network Settings|


.. note:: The Unsafe Browser will not launch when using a manual
	  network configuration if it does not have DNS servers
	  configured. This is technically unnecessary for our use case
	  because we are only using it to access IP addresses on the
	  LAN, and do not need to resolve anything with
	  DNS. Nonetheless, you should configure some DNS servers here
	  so you can continue to use the Unsafe Browser to access the
	  WebGUI in future sessions.

	  We recommend keeping it simple and using the same DNS
	  servers that you used for the network firewall in the setup
	  wizard.


Fill in the static networking information for the *Admin Workstation*:

-  Address: ``10.20.1.2``
-  Netmask: ``255.255.255.0``
-  Gateway : ``10.20.1.1``

|4 NIC Admin Workstation Static IP Configuration|

Click **Apply**. If the network does not come up within 15 seconds or
so, try disconnecting and reconnecting your network cable to trigger the
change. You will need you have succeeded in connecting with your new
static IP when you are able to connect using the Tor Connection assistant,
and you see the message "Connected to Tor successfully".

Troubleshooting: DNS Servers and the Unsafe Browser
'''''''''''''''''''''''''''''''''''''''''''''''''''

After saving the new network configuration, you may still encounter the
"No DNS servers configured" error when trying to launch the Unsafe
Browser. If you encounter this issue, you can resolve it by
disconnecting from the network and then reconnecting, which causes the
network configuration to be reloaded.

To do this, click the network icon in the system toolbar, and click
**Disconnect** under the name of the currently active network
connection, which is displayed in bold. After it disconnects, click
the network icon again and click the name of the connection to
reconnect. You should see a popup notification that says "Connection
Established", and the Tor Connection assistant should show the message "Connected
to Tor successfully".

For the next step, SecureDrop Configuration, you will manually configure the
firewall for SecureDrop, using screenshots as a reference.

SecureDrop Configuration
------------------------

SecureDrop uses the firewall to achieve two primary goals:

#. Isolating SecureDrop from the existing network, which may be
   compromised (especially if it is a venerable network in a large
   organization like a newsroom).
#. Isolating the *Application Server* and the *Monitor Server* from each other
   as much as possible, to reduce attack surface.

In order to use the firewall to isolate the *Application Server* and the *Monitor
Server* from each other, we need to connect them to separate interfaces, and then set
up firewall rules that allow them to communicate.

Enable The OPT1 And OPT2 Interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OPT1 and OPT2 interfaces will be used for the *Application Server* and *Monitor
Server* respectively. To enable them, first connect the *Application Server* to the
physical OPT1 port and the *Monitor Server* to the OPT2 port.

Next, navigate to **Interfaces > Assignments**. LAN and WAN will already be enabled.
Click the **+** button in the **New Interface** section to enable the OPT1 interface
on the next available NIC (``igb2`` in the screenshot below). Once OPT1 has been
added, click **+** again to add OPT2 (on ``igb3`` in the screenshot below)

Finally, click **Save**.

|OPNSense - assign interfaces|

Configure the LAN, WAN, OPT1, and OPT2 interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OPT1 and OPT2 need to be configured to use the subnets defined for the *Application*
and *Monitor Servers*, and some additional configuration is required for the LAN
and WAN interfaces, that is not covered by the Setup Wizard.

Configure the WAN interface
'''''''''''''''''''''''''''''
First, navigate to **Interfaces > [WAN]**. In the **Basic configuration** section,
check the checkbox labeled **Prevent interface removal**.

In the **Generic configuration**
section, make sure that the **Block private networks** and **Block bogon networks**
checkboxes are checked.

Scroll down and click  **Save**, then click **Apply changes** when prompted.

Configure the LAN interface
'''''''''''''''''''''''''''''
Next, navigate to **Interfaces > [LAN]**. In the **Basic configuration** section,
check the checkbox labeled **Prevent interface removal**.

In the **Generic configuration** section, select ``Static IPv4`` in the **IPv4
Configuration Type** dropdown, and ``None`` in the **IPV6 Configuration Type**
dropdown.

Scroll down and click **Save**, then click **Apply changes** when prompted.

Configure the OPT1 interface
'''''''''''''''''''''''''''''
Next, navigate to **Interfaces > [OPT1]**. In the **Basic configuration** section,
check the checkboxes labeled **Enable interface** and **Prevent interface removal**.

In the **Generic configuration** section, select ``Static IPv4`` in the **IPv4
Configuration Type** dropdown, and ``None`` in the **IPV6 Configuration Type**
dropdown.

Scroll down. In the **Static IPv4 Configuration** section, enter the *Application
Gateway* IP address and routing prefix (``10.20.2.1`` and ``24`` if you are using
the recommended values).

Click **Save**, then click **Apply changes** when prompted.

Configure the OPT2 interface
'''''''''''''''''''''''''''''
Finally, navigate to **Interfaces > [OPT2]**. In the **Basic configuration** section,
check the checkboxes labeled **Enable interface** and **Prevent interface removal**.

In the **Generic configuration** section, select ``Static IPv4`` in the **IPv4
Configuration Type** dropdown, and ``None`` in the **IPV6 Configuration Type**
dropdown.

Scroll down. In the **Static IPv4 Configuration** section, enter the *Monitor
Gateway* IP address and routing prefix (``10.20.3.1`` and ``24`` if you are using
the recommended values).

Click **Save**, then click **Apply changes** when prompted.

Configure Firewall Aliases
~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to simplify firewall rule setup, the next step is to configure aliases
for hosts and ports referred to in the rules.

To start, first navigate to **Firewall > Aliases**. You should see some system-defined
aliases as shown below:

|OPNSense - Alias Start|

Click the **+** button to add new aliases. You should add the aliases defined in
the table below (assuming recommended values for IP addresses):

.. list-table:: Firewall Aliases
   :header-rows: 1

   * - Name
     - Type
     - Content

   * - admin_workstation
     - Host(s)
     - ``10.20.1.2``

   * - app_server
     - Host(s)
     - ``10.20.2.2``

   * - external_dns_servers
     - Host(s)
     - ``8.8.8.8``, ``8.8.4.4``

   * - monitor_server
     - Host(s)
     - ``10.20.3.2``

   * - local_servers
     - Host(s)
     - ``app_server``, ``monitor_server``

   * - OSSEC
     - Port(s)
     - ``1514``

   * - ossec_agent_auth
     - Port(s)
     - ``1515``

   * - antilockout_ports
     - Port(s)
     - ``80``, ``443``

When complete, the **Aliases** page should look like this:

|OPNSense - aliases end|

Scroll down and click **Apply** to save and apply your new aliases.

Configure Firewall Rules
~~~~~~~~~~~~~~~~~~~~~~~~

Next, configure firewall rules for each interface.


Configure Firewall Rules on LAN
'''''''''''''''''''''''''''''''
First, navigate to **Firewall > Rules > LAN**.  The LAN interface should have one
automatically-generated anti-lockout rule in place, in addition to two default-allow rules.
The default-allow rules should be removed once the SecureDrop-specific rules below
have been added. The anti-lockout feature should be disabled as a last step.

The rules needed are described in this table:

.. list-table:: Firewall Rules - LAN
   :header-rows: 1

   * - Action
     - TCP/IP Version
     - Protocol
     - Src
     - Src port
     - Dest
     - Dest port
     - Description
   * - Pass
     - IPv4
     - TCP
     - admin_workstation
     - *
     - local_servers
     - 22 (SSH)
     - SSH access for initial install
   * - Pass
     - IPv4
     - TCP
     - admin_workstation
     - *
     - *
     - *
     - Tor from Tails

Add or remove rules until they match the following screenshot including ordering. Click the **+**
button to add a rule.

|OPNSense - Firewall LAN Rules|

Once the rules match, click **Apply Changes.**

Finally, remove the default anti-lockout rule. First, navigate to **Firewall >
Settings > Advanced**. Scroll down to the **Miscellaneous** section and check the
**Disable anti-lockout** checkbox. Then, click **Save**.

|OPNSense - Disable Antilockout|

Configure Firewall Rules On OPT1
''''''''''''''''''''''''''''''''
Next, navigate to **Firewall > Rules > OPT1**. There should be no rules defined
on this interface. Add the rules below:

.. list-table:: Firewall Rules - OPT1
   :header-rows: 1

   * - Action
     - TCP/IP Version
     - Protocol
     - Src
     - Src port
     - Dest
     - Dest port
     - Description
   * - Pass
     - IPv4
     - UDP
     - app_server
     - *
     - monitor_server
     - OSSEC
     - OSSEC Agent
   * - Pass
     - IPv4
     - TCP
     - app_server
     - *
     - monitor_server
     - ossec_agent_auth
     - OSSEC initial auth
   * - **Block**
     - IPv4
     - any
     - OPT1 net
     - *
     - LAN net
     - *
     - Block between OPT1 and LAN by default
   * - **Block**
     - IPv4
     - any
     - OPT1 net
     - *
     - OPT2 net
     - *
     - Block between OPT1 and OPT2 by default
   * - Pass
     - IPv4
     - TCP
     - app_server
     - *
     - *
     - *
     - Tor from App Server
   * - Pass
     - IPv4
     - TCP/UDP
     - app_server
     - *
     - external_dns_servers
     - 53 (DNS)
     - Allow DNS
   * - Pass
     - IPv4
     - UDP
     - app_server
     - *
     - *
     - 123 (NTP)
     - Allow NTP


Once they match the screenshot below, click **Apply Changes**.

|OPNSense Firewall OPT1 Rules|

Configure Firewall Rules On OPT2
''''''''''''''''''''''''''''''''
Next, navigate to **Firewall > Rules > OPT2**. Similarly to OPT1, there should be no rules defined
on this interface. Add the rules below until the rules in the Web GUI match those
in the screenshot:

.. list-table:: Firewall Rules - OPT2
   :header-rows: 1

   * - Action
     - TCP/IP Version
     - Protocol
     - Src
     - Src port
     - Dest
     - Dest port
     - Description
   * - **Block**
     - IPv4
     - any
     - OPT2 net
     - *
     - LAN net
     - *
     - Block between OPT2 and LAN by default
   * - **Block**
     - IPv4
     - any
     - OPT2 net
     - *
     - OPT1 net
     - *
     - Block between OPT2 and OPT1 by default
   * - Pass
     - IPv4
     - TCP
     - monitor_server
     - *
     - *
     - *
     - Tor, SMTP from Monitor Server
   * - Pass
     - IPv4
     - TCP/UDP
     - monitor_server
     - *
     - external_dns_servers
     - 53 (DNS)
     - Allow DNS
   * - Pass
     - IPv4
     - UDP
     - monitor_server
     - *
     - *
     - 123 (NTP)
     - Allow NTP

|OPNSense Firewall OPT2 Rules|

Finally, click **Apply Changes**.

The *Network Firewall* configuration is now complete, allowing you to move
to the next step: :doc:`setting up the servers. <servers>`

Troubleshooting Tips
--------------------

Here are some general tips for setting up OPNSense firewall rules:

#. Create aliases for the repeated values (IPs and ports).
#. OPNSense is a stateful firewall, which means that you don't need
   corresponding rules to allow incoming traffic in response to outgoing
   traffic (like you would in, e.g. iptables with
   ``--state ESTABLISHED,RELATED``).
#. You should create the rules *on the interface where the traffic
   originates*.
#. Make sure you delete the default "allow all" rule on the LAN
   interface.
#. If you are troubleshooting connectivity, the firewall logs can be
   very helpful. You can find them in the Web GUI in **Firewall > Log Files**

.. _Keeping OPNSense up to date:

Keeping OPNSense up to Date
---------------------------

Periodically, the OPNSense project maintainers release an update to the
OPNSense software running on your firewall. You can check for updates using
the link on the OPNSense dashboard.

If you see that an update is available, we recommend installing it. Most
of these updates are for minor bugfixes, but occasionally they can
contain important security fixes. You should keep apprised of updates
yourself by checking the `OPNSense Blog <https://opnsense.org/blog/>`__ or subscribing
to the `OPNSense Blog RSS feed <https://opnsense.org/blog/rss>`__.

.. |Wired Connected| image:: images/firewall/wired_connected.png
.. |OPNSense - Your Connection is Insecure| image:: images/opnsense/opnsense-insecure.png
.. |OPNSENSE - Default Login| image:: images/opnsense/opnsense-login.png
.. |OPNSense - auth server| image:: images/opnsense/opnsense-authservers.png
.. |OPNSense - otpcheck| image:: images/opnsense/opnsense-otpcheck.png
.. |OPNSense - qrscan| image:: images/opnsense/opnsense-qrcode.png
.. |OPNSense - testuserhappy| image:: images/opnsense/opnsense-testuserhappy.png
.. |OPNSense - totp server| image:: images/opnsense/opnsense-totpserver.png
.. |OPNSense - alternate hostnames| image:: images/opnsense/opnsense-alternate-hostname.png
.. |OPNSense General Info| image:: images/opnsense/opnsense-wizard-general.png
.. |OPNSense: Configure LAN Interface| image:: images/opnsense/opnsense-configure-lan.png
.. |OPNSense - No Updates| image:: images/opnsense/opnsense-no-updates.png
.. |OPNSense - Disable DHCP| image:: images/opnsense/opnsense-disable-dhcp.png
.. |OPNSense - assign interfaces| image:: images/opnsense/opnsense-assign-interfaces.png
.. |OPNSense - Alias Start| image:: images/opnsense/opnsense-alias-start.png
.. |OPNSense - aliases end| image:: images/opnsense/opnsense-alias-end.png
.. |OPNSense - Firewall LAN Rules| image:: images/opnsense/opnsense-lan-rules.png
.. |OPNSense - Disable Antilockout| image:: images/opnsense/opnsense-antilockout.png
.. |OPNSense Firewall OPT1 Rules| image:: images/opnsense/opnsense-firewall-opt1.png
.. |OPNSense Firewall OPT2 Rules| image:: images/opnsense/opnsense-firewall-opt2.png
.. |Launching the Unsafe Browser| image:: images/firewall/launching_unsafe_browser.png
.. |You really want to launch the Unsafe Browser| image:: images/firewall/unsafe_browser_confirmation_dialog.png
.. |Pop-up notification| image:: images/firewall/starting_the_unsafe_browser.png
.. |Unsafe Browser Homepage| image:: images/firewall/unsafe_browser.png
.. |Wired Settings| image:: images/firewall/wired_settings.png
.. |Tails Network Settings| image:: images/firewall/tails_network_settings.png
.. |Tails Manual Network Settings| image:: images/firewall/tails-manual-network-with-highlights.png
.. |4 NIC Admin Workstation Static IP Configuration| image:: images/firewall/four_nic_admin_workstation_static_ip_configuration.png
