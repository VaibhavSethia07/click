FROM python:3.11-slim

WORKDIR /app

# Install build dependencies and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python tools
RUN pip install --no-cache-dir pytest flit ruff

# Copy repo files
COPY . .


ENV FLIT_ROOT_INSTALL=1

# Install the package in editable mode
RUN flit install --symlink

# Run tests, lint, and type checks on container start
CMD ["sh", "-c", "pytest -vv && ruff check ."]
