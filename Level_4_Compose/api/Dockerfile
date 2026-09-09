FROM alpine:3.20
RUN apk add --no-cache netcat-openbsd
WORKDIR /app
COPY dienst.sh .
RUN chmod +x dienst.sh
CMD ["./dienst.sh"]
