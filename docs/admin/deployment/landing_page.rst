.. _Landing Page:

*Landing Page*
==============

SecureDrop itself runs as a Tor Onion Service. Organizations also need to
create a SecureDrop *Landing Page* that will:

* explain how SecureDrop works
* give sources instructions on how to access the Tor Onion Service
* disclose the risks of accessing the SecureDrop instance or submitting documents

We also recommend including a privacy policy (see our :ref:`Sample
Privacy Policy`) describing what data is collected and how it will be used by
your organization.

.. note:: SecureDrop will bring more attention to your organization from
          security researchers and others. A *Landing Page* that fails to
          implement minimum security requirements is sure to be noticed, and
          could undermine trust, discouraging possible sources.

*Landing Page* Content Suggestions
----------------------------------

The content below presents sample text for the SecureDrop component of a news
organization’s tips page. It does not account for any specific legal
or organizational needs, but should provide guidance for any outlet getting
started on crafting *Landing Page* language. Any tweaks to the sample content
should be left to the legal and editorial discretion of the individual outlet,
and should be viewed as essential to upholding source protection and transparency.

----

**What is SecureDrop?**

SecureDrop is an anonymity tool for journalists and whistleblowers. As a source,
you can use our SecureDrop installation to anonymously submit documents to our
organization. Our journalists use SecureDrop to receive source materials and
securely communicate with anonymous contacts.

**What should I know before submitting material through SecureDrop?**

To protect your anonymity when using SecureDrop, it is essential that you do
not use a network or device that can easily be traced back to your real
identity. Instead, use public wifi networks and devices you control.

- Do NOT access SecureDrop on your employer’s network.

- Do NOT access SecureDrop using your employer’s hardware.

- Do NOT access SecureDrop on your home network.

- DO access SecureDrop on a network not associated with you, like the wifi at a library or cafe.

**Got it. How can I submit files and messages through SecureDrop?**

Once you are connected to a public network at a cafe or library, download
and install the desktop version of `Tor Browser <https://www.torproject.org/download/>`_.

Launch Tor Browser. Visit our organization’s unique SecureDrop URL at
**http://our-unique-URL.onion/**.
Follow the instructions you find on our source page to
send us materials and messages.

When you make your first submission, you will receive a unique codename.
Memorize it. If you write it down, be sure to destroy the copy as soon as
you’ve committed it to memory. Use your codename to sign back in to
our source page, check for responses from our journalists, and upload
additional materials.

**As a source, what else should I know?**

No tool can absolutely guarantee your security or anonymity.
The best way to protect your privacy and anonymity as a source
is to adhere to best practices.

You can use a separate computer you’ve designated specifically to handle
the submission process.
Or, you can use an alternate operating system like Tails,
which boots from a USB stick and erases your activity at the end of every session.

A file contains valuable `metadata <https://ssd.eff.org/en/module/why-metadata-matters>`_ about its source — when it was created
and downloaded, what machine was involved, the machine’s owner, etc.
You can scrub metadata from some files prior to submission using the Metadata
Anonymization Toolkit featured in Tails.

Your online behavior can be extremely revealing.
Regularly monitoring our publication’s social media or website can potentially
flag you as a source. Take great care to think about what your online behavior
might reveal, and consider using Tor Browser to mitigate such monitoring.

Our organization retains strict access control over our SecureDrop project.
A select few journalists within our organization will have access to
SecureDrop submissions. We control the servers that store your submissions,
so no third party has direct access to the metadata or content of what you send us.

Do not discuss leaking or whistleblowing, even with trusted contacts.

----

.. _The SecureDrop Directory:

The SecureDrop Directory
----------------------------------

SecureDrop `maintains a directory of instances that meet our strict guidelines.
<https://securedrop.org/directory/>`__ If you would like to be considered for
inclusion in this directory, make sure your landing page features the necessary
items from the sample above, and is in compliance with the technical
requirements below, then `send us a request using this form.
<https://securedrop.org/directory/submit/>`__

There are several benefits to being included in the SecureDrop directory. The
most significant benefit is that it will be easier for potential sources to
find your SecureDrop instance. Additionally, being included in the directory
makes you eligible for :doc:`an onion name. <onion_name>`
This improves the experience by turning a lengthy, non-descriptive address
into one that is short and memorable. For example, a long .onion address 
might look like: ::

    sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion

whereas the shorter onion name might look like: ::

    nyworld.securedrop.tor.onion

If you wish to receive an onion name, one can be provided during the
instance verification process. The format for short onion addresses is: ::

    organization.securedrop.tor.onion

where ``organization`` can be any name you request, within reason.

Being included in the SecureDrop directory may make your instance more visible,
which could result in an uptick of illegitimate (spam) submissions.
If you notice an increase in spam after being included in the directory, please
let us know and we can remove your instance from the directory.


URL and Location
----------------

Your *Landing Page* must be a path at your top-level domain, e.g. 
organization.com/securedrop, rather than a subdomain (e.g., 
securedrop.organization.com). This is because DNS and TLS do not always encrypt the hostname,
so a SecureDrop user whose connection is being monitored would be trivially
discovered if you were to use a subdomain.

If the *Landing Page* is deployed on the same domain as another site, you
might consider having some specific configuration (such as the security
headers below) apply only to the /securedrop request URI. This can be done
in Apache by the encapsulating these settings within a
`<Location> <https://httpd.apache.org/docs/2.4/mod/core.html#location>`__
block, which can be defined similarly in nginx by using the
`location {} <https://nginx.org/en/docs/http/ngx_http_core_module.html#location>`__
directive.

.. warning:: Except for rare extenuating circumstances, this is a requirement
             for inclusion in the SecureDrop Directory

HTTPS Only (No Mixed Content)
-----------------------------

HTTPS encryption is the number-one security requirement for your site's
SecureDrop *Landing Page*. Without HTTPS, a source can easily be exposed as a
visitor to your site.

This may be difficult if your website serves advertisements or utilizes
a legacy content delivery network. You should make sure the SecureDrop
*Landing Page* does not serve ads of any kind, even if the rest of your
site does.

If you do not serve ads on any of your site, you should also consider
switching your whole site over to HTTPS by default immediately. If you
do serve ads, consider pressuring your ad networks to enable you to
switch to HTTPS for your entire website in the future.

If your website needs to operate in both HTTPS and HTTP mode, use
protocol-relative URLs for resources such as images, CSS and JavaScript
in common templates to ensure your page does not end up in a mixed
HTTPS/HTTP state.

Consider submitting your domain to be included in the `Chrome HSTS
preload list <https://hstspreload.org/>`__ if you can meet all
of the requirements. This will tell web browsers that the site is only
ever to be reached over HTTPS.

.. warning:: This is a strict requirement for inclusion in
             the SecureDrop Directory

Perfect Forward Secrecy
-----------------------

Perfect Forward Secrecy (PFS) is a property of encryption protocols that
ensures each SSL session has a unique key, meaning that if the key is
compromised in the future it can't be used to decrypt previously
recorded SSL sessions. You may need to talk to your CA (certificate
authority) and CDN (content delivery network) for this, although our
recommended configuration below provides forward secrecy.

SSL Certificate Recommendations
-------------------------------

Regardless of where you choose to purchase your SSL cert and which CA
issues it, you'll often be asked to generate the private key and a CSR
(certificate signing request).

When you do this, it's imperative that you use SHA-2 as the hashing
algorithm instead of SHA-1, which is `being phased
out <https://security.googleblog.com/2014/09/gradually-sunsetting-sha-1.html>`__.
You should also choose a key size of *at least* 2048 bits. These
parameters will help ensure that the encryption used on your *Landing
Page* is sufficiently strong. The following example OpenSSL command will
create a private key and CSR with a 4096-bit key length and a SHA-256
signature:

::

    openssl req -new -newkey rsa:4096 -nodes -sha256 -keyout domain.com.key -out domain.com.csr

**Don't load any resources (scripts, web fonts, etc.) from third parties
(e.g. Google Web Fonts)**

This will potentially leak information about sources to third parties,
which can more easily be accessed by law enforcement agencies. Simply
copy them to your server and serve them yourself to avoid this problem.

Do Not Use Third-Party Analytics, Tracking, or Advertising
----------------------------------------------------------

Most news websites, even those that are non-profits, use third-party analytics
tools or tracking bugs on their websites. It is vital that these are disabled
for the SecureDrop *Landing Page*.

In the past, some news organizations were heavily criticized when launching
their SecureDrop instances because their *Landing Page* contained
trackers. They claimed they were going to great lengths to protect
sources' anonymity, but by having trackers on their *Landing Page*, this also
opened up multiple avenues for third parties to collect information on
those sources. This information can potentially be accessed by law
enforcement or intelligence agencies and could unduly expose a source.

Similarly, consider avoiding Cloudflare (and other CDNs like Akamai, StackPath,
Incapsula, Amazon CloudFront, etc.) for the SecureDrop *Landing Page*. These
services intercept requests between a potential source and the SecureDrop
*Landing Page* and can be used to `track`_ or collect information on sources.

.. warning:: This is a strict requirement for inclusion in
             the SecureDrop Directory

.. _`track`: https://github.com/Synzvato/decentraleyes/wiki/Frequently-Asked-Questions


Do Not Hyperlink .onion Addresses
---------------------------------
Because a visitor to your *Landing Page* may not be using Tor Browser yet,
clicking a link to your SecureDrop instance or to any other .onion address may
result in an error message. Worse, depending on the browser and network
configuration, it may cause lookups that an adversary can use to identify
SecureDrop-related behavior.

Instead, we recommend including .onion addresses in plain text, without a
hyperlink.

If you have been provided a short onion name for your instance, this address
will also need to be plain text, without a hyperlink. We recommend using the
text below to provide maximum clarity: ::

    The SecureDrop instance can be found by entering the following address in
    the desktop version of Tor Browser: <short onion name>

    Alternately, you can access the instance by entering: <long onion address>


.. warning:: This is a strict requirement for inclusion in
             the SecureDrop Directory

Avoid Direct Links to SecureDrop.org
------------------------------------

We appreciate that you may want to link to `the SecureDrop website <https://securedrop.org/>`__
to give *Landing Page* visitors more information about the system. Unfortunately,
if a visitor visits these links without using Tor Browser, this generates
traffic that an adversary may be able to use to identify SecureDrop-related
behavior, regardless of the use of HTTPS.

We suggest offering a reference to the SecureDrop Onion Service in
plain text, without a hyperlink (as per the preceding section):

**sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion**

.. warning:: This is a strict requirement for inclusion in
             the SecureDrop Directory

Apply Security Headers
----------------------

Security headers give instructions to the web browser on how to handle
requests from the web application. These headers set strict rules for
the browser and help mitigate against potential attacks. Given the
browser is a main avenue for attack, it is important these headers are
as strict as possible.

You can use the site
`securityheaders.com <https://securityheaders.com>`__ to easily test
your website's security headers.

If you use Apache, you can use these:

::

    Header set Cache-Control "max-age=0, no-cache, no-store, must-revalidate"
    Header edit Set-Cookie ^(.*)$ $;HttpOnly
    Header set Pragma "no-cache"
    Header set Expires "-1"
    Header always append X-Frame-Options: DENY
    Header set X-XSS-Protection: "1; mode=block"
    Header set X-Content-Type-Options: nosniff
    Header set X-Download-Options: noopen
    Header set X-Permitted-Cross-Domain-Policies: master-only
    Header set Content-Security-Policy: "default-src 'none'; script-src 'self'; style-src 'self'; img-src 'self'; font-src 'self';"
    Header set Referrer-Policy "no-referrer"
    Header set Permissions-Policy "camera 'none'; display-capture 'none'; geolocation 'none'; microphone 'none'; payment 'none'; usb 'none';"

If you intend to run nginx as your webserver instead, this will work:

::

    add_header Cache-Control "max-age=0, no-cache, no-store, must-revalidate";
    add_header Pragma no-cache;
    add_header Expires -1;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options nosniff;
    add_header X-Download-Options noopen;
    add_header X-Permitted-Cross-Domain-Policies master-only;
    add_header Content-Security-Policy "default-src 'none'; script-src 'self'; style-src 'self'; img-src 'self'; font-src 'self';";
    add_header Referrer-Policy "no-referrer";
    add_header Permissions-Policy "camera 'none'; display-capture 'none'; geolocation 'none'; microphone 'none'; payment 'none'; usb 'none';";


Additional Apache Configuration
-------------------------------

To enforce HTTPS/SSL always, you need to set up redirection within the
HTTP (port 80) virtual host:

::

    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}

The same thing can be achieved in nginx with a single line:

::

    return 301 https://$server_name$request_uri;

In your SSL (port 443) virtual host, set up HSTS and use these settings
to give preference to the most secure cipher suites:

::

    Header set Strict-Transport-Security "max-age=16070400;"
    SSLProtocol all -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
    SSLHonorCipherOrder on
    SSLCompression off
    SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH

Here's a similar example for nginx:

::

    add_header Strict-Transport-Security max-age=16070400;
    ssl_protocols TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";

Here's a similar example for nginx if the system supports TLS 1.3:

::

    add_header Strict-Transport-Security max-age=16070400;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers "TLS-CHACHA20-POLY1305-SHA256:TLS-AES-256-GCM-SHA384:TLS-AES-128-GCM-SHA256:EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";

.. note:: We have prioritized security in selecting these cipher suites, so if
          you choose to use them then your site might not be compatible with
          legacy or outdated browsers and operating systems. For a good
          reference check out `Mozilla's recommendations <https://wiki.mozilla.org/Security/Server_Side_TLS>`__.

You'll need to run ``a2enmod headers ssl rewrite`` for all these to
work. You should also set ``ServerSignature Off`` and
``ServerTokens Prod``, typically in /etc/apache2/conf.d/security. For nginx,
use ``server_tokens off;`` so that the webserver doesn't leak extra information.

If you use nginx, `you can follow this
link <https://gist.github.com/mtigas/8601685>`__ and use the
configuration example provided by ProPublica.

.. warning:: Setting the ``Referrer-policy`` header to ``no-referrer`` is a
             strict requirement for inclusion in the SecureDrop directory. 
             Setting the remaining headers as described is strongly
             recommended, but will be reviewed on a case-by-case basis
             for inclusion in the directory and does not necessarily prevent
             the instance from being included.

Set up change detection monitoring for the web application configuration and *Landing Page* content
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If possible, you should set up monitoring to detect changes to the *Landing Page* and the
configuration files of the web server hosting the page. If you do not have an existing
monitoring system for your site, OSSEC is a free and open source host-based intrusion detection suite
that includes a file integrity monitor. More information can be found
`here. <https://www.ossec.net/>`__

.. note:: We do not recommmend using the *Monitor Server* to monitor your landing page. It should be used
  for the *Application Server* only.

Don't log access to the *Landing Page* in the webserver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here's an Apache example that would exclude the *Landing Page* from
logging. However you still need to make sure no other assets get logged!

::

    SetEnvIf Request_URI "^/securedrop($|(\/.*))" dontlog
    CustomLog logs/access_log common env=!dontlog

In nginx, logging can be disabled by adding the following directives within the
*Landing Page* ``location {}`` block:

::

    access_log off;
    error_log /dev/null;


Further Security Considerations
-------------------------------

To guard your *Landing Page* against being modified by an attacker and
directing sources to a rogue SecureDrop instance, you will need good
security practices applying to the machine where it is hosted. Whether
it's a VPS in the cloud or dedicated server in your office, you should
consider the following:

-  Brute force login protection (see `fail2ban`_ or `sshguard`_)
-  Disable root SSH login
-  Use SSH keys instead of passwords
-  Use long, random and complex passwords
-  Firewall rules to restrict accessible ports (see iptables or ufw)
-  AppArmor, grsecurity, SELINUX, modsecurity
-  Intrusion and/or integrity monitoring (see Logwatch, OSSEC, Snort,
   rkhunter, chkrootkit)
-  Downtime alerts (Nagios or Pingdom)
-  Two-factor authentication (see libpam-google-authenticator,
   libpam-yubico)

It's preferable for the *Landing Page* to have its own segmented
environment instead of hosting it alongside other sites running
potentially vulnerable software or content management systems. Check
that user and group file permissions are locked down and that modules or
gateway interfaces for dynamic scripting languages are not enabled. You
don't want any unnecessary code or services running as this increases
the attack surface.

.. _`fail2ban` : https://github.com/fail2ban/fail2ban
.. _`sshguard` : https://bitbucket.org/sshguard/sshguard/

How to test your *Landing Page* using Tor Browser
-------------------------------------------------

*Sources* may visit your *Landing Page* using Tor.

Many websites are configured with security measures that only apply
when Tor is in use. For example, Tor visitors may be requested to solve
a CAPTCHA, may trigger warnings that are specific to some Tor exit nodes,
or may be unable to load the page altogether because of
Tor-specific DDoS protections.

The effect of such measures cannot be tested without using Tor, and it is
a very bad experience for a *source* if visiting a *Landing Page* doesn't work
as expected. Because of that, we **recommended strongly** that you test
your organization's *Landing Page* using Tor *before* you start advertising it.

You can do so using Tor Browser:

#. Download Tor Browser from the `Tor Project website`_.
#. Ensure the `Tor Browser security level`_ is set to "Safest"
   by clicking on the shield icon. If not, click "Settings…", 
   then "Change…", then select "Safest". Finally, click
   "Save and restart" to re-launch the browser and apply
   the new settings.
#. Visit your *Landing Page*.
#. Verify that everything works as expected.
#. Reload the page `using a different Tor circuit`_ by clicking on
   "New Tor Circuit for this Site" in the site information menu (padlock icon in
   the URL bar) or in the hamburger menu.
#. Verify that everything still works as expected.
#. Repeat the previous two steps several times to test with exit nodes in
   different countries and regions.

.. _`Tor Project website`: https://www.torproject.org/
.. _`Tor Browser security level`: https://tb-manual.torproject.org/security-settings/
.. _`using a different Tor circuit`: https://tb-manual.torproject.org/managing-identities/
