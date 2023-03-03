# sha256 as of 2023-01-17
FROM python:3.9-slim-bullseye@sha256:8b0502fe3a8ae9d26567f66e217223595ff6abe901cba64fd8b1b58176311b27 AS sphinx

ARG GIT_BRANCH=main
RUN apt-get -q update && apt-get -qy upgrade && apt-get -qy install git make latexmk texlive-latex-extra
COPY ./ .
RUN pip install poetry==1.4.0
RUN poetry install
# TODO: Once the latest stable tag uses poetry, we can drop the `poetry run` prefix
RUN poetry run deploy/build $GIT_BRANCH

# sha256 as of 2021-11-09
FROM nginx:mainline-alpine@sha256:af466e4f12e3abe41fcfb59ca0573a3a5c640573b389d5287207a49d1324abd8

COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot/en/latest /opt/nginx/webroot/en/stable && chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx --chown=nginx:nginx build/stable/html/html/ /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/stable/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/html/ /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/latest/
