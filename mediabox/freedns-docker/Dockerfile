FROM alpine:latest

ENV CRON_HOUR=* \
    CRON_MIN=*/5 \
    CRON_SEC=5

ENV FREEDNS_URL="https://freedns.afraid.org/dynamic/update.php?"
ENV TOKENS="OUtYTllueEdYWFFEaUdvdldCSUg6NjgxNjEzOA=="

CMD echo -e "#!/bin/sh\necho \"\${TOKENS}\" | while read key; do wget -O- \"\$FREEDNS_URL\${key%%#*}\"; done" > /usr/local/bin/update-freedns.sh && \
    chmod +x /usr/local/bin/update-freedns.sh && \
    echo -e "${CRON_MIN} ${CRON_HOUR} * * * sleep ${CRON_SEC}; date; /usr/local/bin/update-freedns.sh" \
        | crontab -u cron - && \
    exec crond -d 6 -f
