FROM alpine:3.7
RUN apk add --no-cache git
RUN git clone https://github.com/faulander/P4S.git
WORKDIR /P4S
RUN cp .env.prod.example .env.prod
RUN cp .env.prod.db.example .env.prod.db
RUN chmod +x *.sh
RUN ls
RUN /P4S/firststart.prod.sh
ENTRYPOINT ["./startapp.prod.sh"]
