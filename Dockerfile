# syntax=docker/dockerfile:1
FROM frostedcarbon/tfc-cli:v1.0.0 AS get-tfc-cli
FROM python:3.9.9-slim-bullseye
COPY --from=get-tfc-cli ./tfc-cli /
COPY entrypoint.py /
ENTRYPOINT ["/entrypoint.py"]
