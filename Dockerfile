FROM alpine:3.11

# Set WORKDIR
ENV APPDIR /usr/local/app
WORKDIR $APPDIR
COPY . $APPDIR

RUN apk --update-cache add \
    musl \
    linux-headers \
    gcc \
    g++ \
    make \
    gfortran \
    openblas-dev \
    python3 \
    python3-dev && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [ ! -e /usr/bin/python ]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip install --no-cache-dir --upgrade pip setuptools wheel flask && \
    pip install --no-cache-dir ginza && \
    rm -r /root/.cache

CMD ["python", "src/server.py"]
