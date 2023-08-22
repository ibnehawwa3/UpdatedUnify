FROM ghcr.io/cirruslabs/flutter as builder
RUN sudo apt update && sudo apt install curl -y
COPY . /app
WORKDIR /app
RUN ./scripts/prepare-web.sh
RUN flutter pub get
RUN flutter build web --release --source-maps

FROM docker.io/nginx:alpine
RUN rm -rf /usr/share/nginx/html
COPY --from=builder /app/build/web /usr/share/nginx/html