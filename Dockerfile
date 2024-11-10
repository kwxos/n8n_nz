FROM n8nio/n8n:latest


COPY docker-entrypoint.sh /

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
