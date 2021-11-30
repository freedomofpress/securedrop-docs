# sha256 as of 2021-11-09
FROM python:3.9-slim-bullseye@sha256:408de0cf1a057f5501ee6642ad24a4762738f63bacf09fb4c8d861669260b01e AS sphinx

RUN apt-get -q update && apt-get -qy upgrade && apt-get -qy install git make latexmk texlive-latex-extra
COPY ./ .
RUN pip install -r requirements/requirements.txt
RUN deploy/build

# sha256 as of 2021-11-09
FROM nginx:mainline-alpine@sha256:af466e4f12e3abe41fcfb59ca0573a3a5c640573b389d5287207a49d1324abd8

COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot/en/latest /opt/nginx/webroot/en/stable && chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx --chown=nginx:nginx build/stable/html/html/ /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/stable/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/html/ /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/latest/
