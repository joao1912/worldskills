FROM alpine:latest

# if x86 ? debian:latest : alpine:latest

WORKDIR /app

COPY binario /app/binario

RUN chmod +x /app/binario

# se precisar fazer req https, precisa instalar esses pacotes
#
# RUN apk/apt-get update
#
# RUN apk/apt-get add/install --no-cache/-y ca-certificates
#
# RUN update-ca-certificates

# Se necessario 
# RUN set +H

EXPOSE 80

CMD ["/app/binario"]
