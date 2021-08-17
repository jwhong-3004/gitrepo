FROM 10.10.10.149:32002/jwtest/app:test
COPY app.js .
ENTRYPOINT ["docker-entrypoint.sh"]	
CMD ["/bin/sh", "-c", "node app.js"]
