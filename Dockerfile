FROM n8nio/n8n:latest

RUN apk update && \
    apk add --no-cache wget bash
    
COPY docker-entrypoint.sh /

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
