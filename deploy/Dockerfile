FROM debian:trixie AS sphinx

ARG GIT_BRANCH=main
RUN apt-get -q update && apt-get -qy upgrade && apt-get -qy install git make latexmk texlive-latex-extra python3-poetry
COPY ./ .
RUN poetry install
RUN deploy/build $GIT_BRANCH

# sha256 as of 2024-06-10
FROM nginx:mainline-alpine-slim@sha256:244d37691a469d45349d9f29e8b7462d9f510b70c0c93acc5d23ee227070c962

COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot/en/latest /opt/nginx/webroot/en/stable && chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx --chown=nginx:nginx build/stable/html/html/ /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/stable/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/html/ /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/2.12/html/html/ /opt/nginx/webroot/en/2.12/
COPY --from=sphinx --chown=nginx:nginx build/2.12/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/2.12/
