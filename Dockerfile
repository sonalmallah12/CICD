FROM alpine:3.19
WORKDIR /app
COPY app.sh .
CMD ["sh", "app.sh"]

