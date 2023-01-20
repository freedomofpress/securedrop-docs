# sha256 as of 2023-01-17
FROM python:3.9-slim-bullseye@sha256:8b0502fe3a8ae9d26567f66e217223595ff6abe901cba64fd8b1b58176311b27 AS sphinx

ARG GIT_BRANCH=main
RUN apt-get -q update && apt-get -qy upgrade && apt-get -qy install git make latexmk texlive-latex-extra
COPY ./ .
RUN pip install --upgrade pip
RUN pip install poetry
RUN poetry install
RUN poetry run deploy/build $GIT_BRANCH

# sha256 as of 2023-01-09

FROM nginx:mainline-alpine@sha256:c1b9fe3c0c015486cf1e4a0ecabe78d05864475e279638e9713eb55f013f907f
COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot/en/latest && chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx --chown=nginx:nginx build/latest/html/ /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/latest/latex/SecureDropSupport.pdf /opt/nginx/webroot/en/latest/
