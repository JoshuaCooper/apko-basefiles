FROM cgr.dev/chainguard/python:latest-dev AS server
USER root
WORKDIR /work/packages/
ENTRYPOINT ["python3", "-m", "http.server", "8000"]
