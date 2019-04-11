## Development Workflow

To render the docs locally:

* Install [pipenv](https://docs.pipenv.org/) with `pip install pipenv`;
* Clone and enter the repository: `git clone https://github.com/freedomofpress/redmine_docs.git && cd redmine_docs/`;
* Install the requirements with `pipenv install`;
* Do `pipenv run make docs`;
* Open a browser and point to http://localhost:8000.

Before submitting a PR, please test for any formatting problems with `pipenv run make docs-lint`.
