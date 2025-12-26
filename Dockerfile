# Build stage
FROM rust:slim AS builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy workspace files
COPY Cargo.toml ./
COPY main.rs ./
COPY crates ./crates

# Build the application
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -m -u 1000 between

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/target/release/between-api .

# Change ownership
RUN chown -R between:between /app

# Switch to app user
USER between

# Expose port
EXPOSE 8000

# Run the application
CMD ["./between-api"]
