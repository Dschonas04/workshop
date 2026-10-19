FROM alpine:3.20

WORKDIR /app

RUN adduser -D dienst

COPY start.sh .

RUN chmod +x start.sh

ENV NAME=workshopbild

USER dienst

CMD ["./start.sh"]
