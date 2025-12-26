# Between - Silence Module API

REST API for the Between platform's Silence module. Allows users to consciously log periods of silence in their daily lives.

## Prerequisites

- Rust 1.75+
- PostgreSQL 14+
- Docker & Docker Compose (optional)

## Quick Start

### 1. Setup Environment

Copy and configure environment variables:

```bash
cp .env.example .env
```

Edit `.env` with your database credentials and JWT secret.

### 2. Start Database

Using Docker:

```bash
docker-compose up -d postgres
```

Or use your local PostgreSQL instance.

### 3. Run Migrations

```bash
cargo install sea-orm-cli
sea-orm-cli migrate up
```

### 4. Start Server

```bash
cargo run
```

Server starts at `http://localhost:8000`

## API Documentation

Interactive API documentation available at:
- Swagger UI: `http://localhost:8000/swagger-ui/`
- OpenAPI JSON: `http://localhost:8000/api-docs/openapi.json`

## API Endpoints

### Health Check

**Check Service Health**
```bash
curl http://localhost:8000/health
```

Response (200 OK):
```json
{
  "data": {
    "postgres": true
  },
  "success": true,
  "status_code": 200,
  "timestamp": "2025-12-19T16:40:00Z"
}
```

Response (503 Service Unavailable):
```json
{
  "data": {
    "postgres": false
  },
  "message": "Database connection failed",
  "success": false,
  "status_code": 503,
  "timestamp": "2025-12-19T16:40:00Z",
  "error_code": "DATABASE_UNHEALTHY"
}
```

### Authentication

**Register User**
```bash
curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullname": "John Doe",
    "email": "john@example.com",
    "password": "securepass123",
    "timezone": "UTC"
  }'
```

**Login**
```bash
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "securepass123"
  }'
```

Response includes `access_token` and `refresh_token`.

**Refresh Token**
```bash
curl -X POST http://localhost:8000/api/auth/refresh-token \
  -H "Content-Type: application/json" \
  -d '{
    "refresh_token": "your_refresh_token_here"
  }'
```

### Silence Sessions

All silence endpoints require authentication header:
```
Authorization: Bearer <access_token>
```

**Start Silence Session**
```bash
curl -X POST http://localhost:8000/api/silence/start \
  -H "Authorization: Bearer <access_token>"
```

**End Silence Session**
```bash
curl -X POST http://localhost:8000/api/silence/end \
  -H "Authorization: Bearer <access_token>"
```

**Attach Context to Session**
```bash
curl -X PUT http://localhost:8000/api/silence/sessions/{session_id}/context \
  -H "Authorization: Bearer <access_token>" \
  -H "Content-Type: application/json" \
  -d '{
    "context_code": 1
  }'
```

Context codes:
- 1: alone
- 2: waiting
- 3: walking
- 4: thinking
- 5: empty

**Get Session History**
```bash
curl http://localhost:8000/api/silence/sessions \
  -H "Authorization: Bearer <access_token>"
```

Optional query parameters:
- `limit`: Number of sessions (default: 50)
- `offset`: Pagination offset (default: 0)

**Get Statistics**
```bash
curl http://localhost:8000/api/silence/stats \
  -H "Authorization: Bearer <access_token>"
```

## Testing Complete Flow

```bash
# 0. Check health
curl http://localhost:8000/health

# 1. Register
TOKEN=$(curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"fullname":"Test User","email":"test@example.com","password":"test123","timezone":"UTC"}' \
  | jq -r '.data.tokens.access_token')

# 2. Start silence
SESSION=$(curl -X POST http://localhost:8000/api/silence/start \
  -H "Authorization: Bearer $TOKEN" \
  | jq -r '.data.id')

# 3. Wait a moment
sleep 10

# 4. End silence
curl -X POST http://localhost:8000/api/silence/end \
  -H "Authorization: Bearer $TOKEN"

# 5. Attach context
curl -X PUT http://localhost:8000/api/silence/sessions/$SESSION/context \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"context_code":1}'

# 6. View history
curl http://localhost:8000/api/silence/sessions \
  -H "Authorization: Bearer $TOKEN"

# 7. View stats
curl http://localhost:8000/api/silence/stats \
  -H "Authorization: Bearer $TOKEN"
```

## Project Structure

```
src/
├── lib.rs              # Library exports
├── main.rs             # Server entry point
├── app.rs              # Router configuration
├── config/             # Environment configuration
├── db/                 # Database connection
├── domain/             # Business logic
│   ├── silence/        # Silence domain
│   └── user/           # User domain
├── infrastructure/     # Technical implementations
│   ├── shutdown/       # Graceful shutdown
│   ├── silence/        # Silence repository
│   └── user/           # User repository
├── application/        # HTTP handlers
│   ├── silence/
│   └── user/
└── shared/             # Shared utilities

migration/              # Database migrations
```

## Configuration

Environment variables in `.env`:

```bash
# Database
DB_USERNAME=postgres
DB_PASSWORD=admin
DB_HOST=localhost
DB_PORT=5432
DB_NAME=between

# JWT
JWT_SECRET=your-secret-key-change-in-production
JWT_ACCESS_TOKEN_EXPIRY=86400    # 1 day
JWT_REFRESH_TOKEN_EXPIRY=432000  # 5 days

# Server
API_HOST=localhost
API_PORT=8000

# Logging
RUST_LOG=info
```

## Graceful Shutdown

The server handles SIGTERM and SIGINT (Ctrl+C) gracefully:
- Stops accepting new requests
- Waits for in-flight requests to complete
- Closes database connections cleanly

Press Ctrl+C to test graceful shutdown.

## Development

**Build**
```bash
cargo build
```

**Run tests**
```bash
cargo test
```

**Run with debug logging**
```bash
RUST_LOG=debug cargo run
```

## License

MIT
