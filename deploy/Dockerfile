# sha256 as of 2021-11-09
FROM python:3.9-slim-bullseye@sha256:408de0cf1a057f5501ee6642ad24a4762738f63bacf09fb4c8d861669260b01e AS sphinx

RUN apt-get -q update && apt-get -qy upgrade && apt-get install make
COPY ./ .
RUN pip install -r requirements/requirements.txt
RUN make html

# sha256 as of 2021-11-09
FROM nginx:mainline-alpine@sha256:af466e4f12e3abe41fcfb59ca0573a3a5c640573b389d5287207a49d1324abd8

COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot && chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx docs/_build/html/html/ /opt/nginx/webroot/
