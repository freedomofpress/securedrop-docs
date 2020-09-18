<p align="center">
  <img src="/static/i/logo.png" width="350" height="314">
</p>

SecureDrop is an open-source whistleblower submission system that media organizations can use to securely accept documents from, and communicate with anonymous sources. It was originally created by the late Aaron Swartz and is currently managed by the [Freedom of the Press Foundation](https://freedom.press).

This is repository is still in beta. It will eventually be used to build the [public documentation](https://docs.securedrop.org/en/stable/) for SecureDrop.

## Quickstart

1. Create a virtual environment with `python3 -m venv .venv` or the tooling of your choice
2. Activate your virtual environment (e.g., `source .venv/bin/activate`)
3. Ensure you are using an up-to-date version of `pip` in the virtual environment (e.g., `pip install --upgrade pip`)
4. Install the project requirements with `pip install --require-hashes -r requirements/requirements.txt`
5. Run `make docs` to start a live build of the documentation at http://localhost:8000
6. Edit RST files under the docs directory - your changes will be reflected in the live build

## License

SecureDrop is open source and released under the [GNU Affero General Public License v3](/LICENSE).
