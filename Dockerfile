FROM ubuntu as build-step
COPY . /app

from nginx
copy --from=build-step /app/party-time /usr/share/nginx/html

