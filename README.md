<p align="center">
  <img src="/static/i/logo.png" width="350" height="314">
</p>

SecureDrop is an open-source whistleblower submission system that media organizations can use to securely accept documents from, and communicate with anonymous sources. It was originally created by the late Aaron Swartz and is currently managed by the [Freedom of the Press Foundation](https://freedom.press).

This repository is used to build the [public documentation](https://docs.securedrop.org/) for SecureDrop.

## Quickstart

1. [Install poetry](https://python-poetry.org/docs/#installation)
2. Install the dependencies using `poetry install`
3. Run `make docs` to start a live build of the documentation at http://localhost:8000
4. Edit [RST](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html) files under the docs directory - your changes will be reflected in the live build

## License

SecureDrop is open source and released under the [GNU Affero General Public License v3](/LICENSE).
