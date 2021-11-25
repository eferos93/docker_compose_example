FROM jolielang/jolie
LABEL maintainer="Eros <eros.fabrici@gmail.com>"
EXPOSE 8000
COPY . .
CMD [ "jolie --params params.json app.ol" ]
