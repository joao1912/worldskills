FROM alpine:latest

# if x86 ? debian:latest : alpine:latest

WORKDIR /app

COPY binario /app/binario

RUN chmod +x /app/binario

# Se necessario 
# RUN set +H

EXPOSE 80

CMD ["/app/binario"]
