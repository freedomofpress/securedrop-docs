Overview
========

One of Redmine's strengths as a ticketing system is its powerful support
for email-based workflow. You can use email to create new issues, reply
to existing issues, and be notified of updates to issues that are
relevant to you.

While many people find email-based workflows convenient, email is
unfortunately insecure by default. Freedom of the Press Foundation takes
the security of every SecureDrop instance seriously; therefore, we
require the use of encryption for support requests because they may
contain sensitive information about your SecureDrop instance.

The web interface workflow is automatically encrypted thanks to HTTPS.
Supporting a secure email-based workflow is more difficult because email
is unencrypted by default. Our solution is to combine Redmine's
excellent email-based workflow with OpenPGP encryption, which we already
use to communicate with many SecureDrop administrators and journalists.
