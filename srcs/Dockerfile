# To remove the load on the final stage
# Build stage
FROM python:3.10-alpine as builder

RUN apk update && apk add build-base

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.10-alpine

COPY --from=builder /app /app
WORKDIR /app

CMD ["python", "app.py"]