FROM python:3.10.11-alpine3.18

ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add --no-cache \
    build-base \
    libffi-dev \
    bash \
    sqlite \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY  requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

