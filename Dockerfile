FROM python:3.10-slim as base

ARG COREDW_RO_PASSWORD

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    AWS_REGION='us-west-2' \
    AWS_DEFAULT_REGION='us-west-2' \
    COREDW_RO_PASSWORD=$COREDW_RO_PASSWORD

WORKDIR /home/root

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.4.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        git \
        curl

COPY requirements.txt ./
COPY models/ models/
COPY tests/ tests/
COPY dbt_project.yml ./
COPY packages.yml ./
COPY profiles.yml ./


RUN pip install -r requirements.txt
RUN dbt deps
