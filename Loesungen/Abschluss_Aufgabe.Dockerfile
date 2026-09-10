FROM alpine:3.20
WORKDIR /app
COPY zaehl.sh .
RUN chmod +x zaehl.sh
ENV DIENST=zaehler
CMD ["./zaehl.sh"]
