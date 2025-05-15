FROM python:3.13.3

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    git clone https://github.com/aliyun/alibabacloud-observability-mcp-server /alibabacloud-observability-mcp-server && \
    mkdir /etc/uv

RUN mv /root/.local/bin/* /bin

COPY config.json /config.json
COPY uv.toml /etc/uv/uv.toml

RUN uv tool install mcpo && uv tool install mcp-server-aliyun-observability@0.2.5 && uv tool install alibabacloud-rds-openapi-mcp-server@1.6.3 && uv tool install alibaba-cloud-ops-mcp-server@0.8.6

ENTRYPOINT [ "uvx", "mcpo", "--port", "3000", "--config", "/config.json" ]