FROM python:3.10-alpine

ENV PYTHONUNBUFFERED 1

COPY ./app /app

WORKDIR /app 

RUN python -m venv /venv && /venv/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev

COPY requirements.txt .
RUN pip install -r requirements.txt && \
    apk del .tmp-build-deps

CMD ["python3","manage.py","runserver"]
