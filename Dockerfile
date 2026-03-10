FROM python:3.12.12-slim

LABEL maintainedBy="Gaurav Girase" \
      org.opencontainer.image.name="Django-ecs-application" \
      org.opencontainer.image.description="Django-application starter template" \
      org.opencontainer.image.version="1.0.0"

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip
COPY ./requirements.txt /app/
RUN pip install -r requirements.txt

# Create a user with UID 1000 and GID 1000
RUN groupadd -g 1000 appgroup && \
    useradd -r -u 1000 -g appgroup appuser

USER 1000:1000

COPY . .

ENTRYPOINT ["gunicorn"]

CMD ["hello_django.wsgi:application", "--bind", "0.0.0.0:8000"]
