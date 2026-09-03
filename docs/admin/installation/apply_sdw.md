# Apply configuration to Admin Workstation

With the servers installed and configured, the final step is to configure the Admin Workstation.

(install_configure_securedrop_app)=

## Configure SecureDrop Workstation

- These steps should be performed from a `dom0` terminal. **Start a dom0 terminal** via ![Qubes Application menu](../../images/qubes_menu.png) **▸** ![System Tools](../../images/qubes_menu_gear.png) **▸ Other Tools ▸ Xfce Terminal**.

- Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.

- Finally, in the `dom0` terminal, run the command:

  ```sh
  sdw-admin --apply
  ```

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation. This SecureDrop Workstation is finally ready to use!

## Test the SecureDrop Workstation

The preflight updater will start automatically after logging into the system. Please follow the preflight updater's instructions.

:::{note}
If you close SecureDrop Inbox during your session, you can launch it again using the SecureDrop icon on the desktop.
:::

Once the update check is complete, [SecureDrop Inbox](#glossary_securedrop_inbox) will launch. Log in using an existing journalist account and verify that Sources are listed and new messages and files can be downloaded, decrypted, and viewed.

(password-management-section)=

## Enable password copy and paste

If you use KeePassXC in the `vault` qube to manage login credentials, you can enable the user to copy passwords to SecureDrop Inbox using inter-qube copy and paste. While this is relatively safe, we recommend reviewing the section [Managing Clipboard Access](/admin/workstation_reference/managing_clipboard.md) of this guide, which goes into further detail on the security considerations for inter-qube copy and paste.

The password manager runs in the networkless `vault` qube, and the SecureDrop Inbox application runs in the `sd-app` qube. To permit this one-directional clipboard use, issue the following command in `dom0`:

```sh
qvm-tags vault add sd-send-app-clipboard
```

Confirm that the tag was correctly applied using the `ls` subcommand:

```sh
qvm-tags vault ls
```

To revoke this configuration change later or correct a typo, you can use the `del` subcommand, e.g.:

```sh
qvm-tags vault del sd-send-app-clipboard
```

### Troubleshooting `sdw-admin`

## "Failed to return clean data"

An error similar to the following may be displayed during an installation or update:

```none
sd-log:
      ----------
      _error:
          Failed to return clean data
      retcode:
          None
      stderr:
      stdout:
          deploy
```

This is a transient error that may affect any of the SecureDrop Workstation qubes. To clear it, run the installation command or update again.

## "Temporary failure resolving"

Transient network issues may cause an installation to fail. To work around this, verify that you have a working Internet connection, and re-run the `sdw-admin --apply` command.
