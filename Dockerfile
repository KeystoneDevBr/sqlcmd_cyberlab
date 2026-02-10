
FROM ubuntu:noble-20260113@sha256:cd1dba651b3080c3686ecf4e3c4220f026b521fb76978881737d24f200828b2b

# Install Microsoft SQL Server mssql-tools18 for sqlcmd and bcp
# Source: https://learn.microsoft.com/pt-br/sql/linux/sql-server-linux-setup-tools 
# -----------------------------------------------------------------------------------------------------
ENV ACCEPT_EULA=Y
ENV PATH="/opt/mssql-tools18/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    iputils-ping \
    # Download and install the Microsoft repository configuration package
    && curl -sSL -O https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb \
    -o packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    # CLI Tools for SQL Server
    mssql-tools18 \
    # Cleanup
    && rm packages-microsoft-prod.deb \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the default command to bash, which will allow us to run sqlcmd and bcp interactively
CMD ["bash"]
