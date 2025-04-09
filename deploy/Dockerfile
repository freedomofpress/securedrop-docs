FROM debian:bookworm AS sphinx

ARG GIT_BRANCH=main
RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -qy install \
      git \
      make \
      latexmk \
      texlive-latex-extra \
      python3 \
      python3-venv

# Create a dedicated venv for Poetry and install pinned version compatible with Dependabot
RUN python3 -m venv /opt/poetry-venv
RUN /opt/poetry-venv/bin/pip install --upgrade pip && \
    /opt/poetry-venv/bin/pip install "poetry==2.1.2"

# Make the 'poetry' command available system-wide so Makefile targets work
RUN ln -s /opt/poetry-venv/bin/poetry /usr/local/bin/poetry

COPY . .
RUN poetry install --no-root
RUN deploy/build $GIT_BRANCH

# sha256 as of 2025-02-14 image
FROM nginx:mainline-alpine-slim@sha256:b05aceb5ec1844435cae920267ff9949887df5b88f70e11d8b2871651a596612

COPY deploy/nginx.conf /etc/nginx
RUN mkdir -p /opt/nginx/run /opt/nginx/webroot/en/latest /opt/nginx/webroot/en/stable && \
    chown -R nginx:nginx /opt/nginx

USER nginx
COPY --from=sphinx --chown=nginx:nginx build/stable/html/html/ /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/stable/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/stable/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/html/ /opt/nginx/webroot/en/latest/
COPY --from=sphinx --chown=nginx:nginx build/latest/html/latex/SecureDrop.pdf /opt/nginx/webroot/en/latest/
