# Using a YubiKey with the Admin Interface

This guide describes in detail how to set up a YubiKey for two-factor authentication on the [Admin Interface](#glossary_admin_interface). This setup is performed once per Journalist to create a secure log-in method. The process requires some configuration steps using a separate software tool.

:::{note}
You will do all of these steps from within the Tails operating system.
:::

## What is a YubiKey?

A YubiKey is a physical token used for two-factor authentication. They are made by a company called Yubico and are [commercially available]. Note that not all physical tokens are compatible with the YubiKey Personalization Tool; for this, you require [a key that can support OATH-HOTP].

## Download and launch the YubiKey personalization tool

1. Start Tails. At the log in-screen, choose the option to allow an administrator passphrase.
2. Open a terminal and enter

```sh
sudo apt-get update;
sudo apt-get install yubikey-personalization-gui
```

1. Once you have downloaded and installed the personalization program, open a **Root Console** by choosing **Apps ▸ System Tools ▸ Root Console**.
2. Open the YubiKey personalization tool by entering

```sh
yubikey-personalization-gui
```

## Setting up hardware-based codes

After opening the personalization tool, click the heading **OATH-HOTP**. This will bring you to a window called **Program in OATH-HOTP mode**.

Click on the **Quick** button.

![YubiKey Overview](../../images/yubikey_overview.png)

Under **Configuration Slot**, click **Configuration Slot 1**.

:::{note}
If you are already using this YubiKey for something else, you should choose **Configuration Slot 2**. You will have to press and hold for several seconds to use the token from **Slot 2** instead of the one in **Slot 1**. See the [YubiKey manual] for more information.
:::

In the section titled **OATH-HOTP parameters**, uncheck the box for **OATH Token Identifier (6 bytes)**. Leave the HOTP length at 6 digits. Next, uncheck the box for **Hide secret**. This will display the **Secret Key (20 bytes Hex)** field.

:::{important}
Make a note somewhere safe of the **Secret Key (20 bytes Hex)** value.
:::

![YubiKey Config](../../images/yubikey_oath_hotp_configuration.png)

When ready, click the **Write Configuration** button.

Click through the warning about overwriting the configuration slot and choose a location to save the log file. When the configuration is done, you should see green text saying **YubiKey configured** at the top of the window.

![YubiKey Config Successful](../../images/yubikey_configuration_successful.png)

## Adding users

When adding new users, a SecureDrop Administrator will need the **Secret Key** value described above. She will enter it after selecting the **I'm Using a YubiKey** option while [adding users](#adding-users). The new user will then have to verify their YubiKey before being added to the system. This means that the new user and the Administrator should be physically present for this process.

## Using your YubiKey

When using a Yubikey to log-in to the Admin Interface, insert the Yubikey into the USB port and enter your username and passphrase. Then click the **Two-factor Code** field to focus the cursor there. Quickly press the lighted button on your YubiKey. This will insert the 6-digit code that you will need to log in.

:::{note}
When using **Configuration Slot 2**, be sure to press and hold the YubiKey button for approximately 3 seconds. This can be somewhat finicky.
:::

[a key that can support oath-hotp]: https://support.yubico.com/hc/en-us/articles/360016614780-OATH-HOTP-Yubico-Best-Practices-Guide
[commercially available]: https://www.yubico.com/authentication-standards/fido-u2f/
[yubikey manual]: https://docs.yubico.com/hardware/yubikey/yk-5/tech-manual/index.html
