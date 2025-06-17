# Imagem base Amazon Linux 2
FROM public.ecr.aws/lambda/provided:al2-x86_64

RUN yum install -y curl

COPY location-app /app/location-app
RUN chmod +x /app/location-app

RUN echo '#!/bin/bash' > /var/runtime/bootstrap && \
    echo 'EVENT_DATA=$(curl -sS -LD /tmp/h -X GET "http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01/runtime/invocation/next")' >> /var/runtime/bootstrap && \
    echo 'REQUEST_ID=$(grep -Fi Lambda-Runtime-Aws-Request-Id /tmp/h | cut -d: -f2 | tr -d " \r")' >> /var/runtime/bootstrap && \
    echo '/app/location-app' >> /var/runtime/bootstrap && \
    echo 'curl -X POST "http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01/runtime/invocation/$REQUEST_ID/response" -d "{\"status\":\"done\"}"' >> /var/runtime/bootstrap && \
    chmod +x /var/runtime/bootstrap

CMD ["bootstrap"]