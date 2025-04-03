# Test task implementation

Functional requirements:
> We have forum users and their comments. We need to design an API that allows moderators to get a list of users and their comments.

API was implemented with Grape and Swagger.

Swagger UI:  
http://localhost:3000/api/swagger

Swagger JSON:
```
curl -s http://localhost:3000/api/v1/swagger_doc.json | jq '.'
```

## How to launch project with Docker Compose
Install Docker Compose (https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).
Then run
```
# Launching in interactive mode
docker-compose up
```
Or
```
# Launching in background mode
docker-compose up -d
```

## How to populate DB with sample data
```
docker-compose up -d
docker-compose exec web rails db:seed
```

## How to run tests with Docker Compose
```
docker-compose up -d
docker-compose exec web rspec
```

## How to run the linter with Docker Compose
```
docker-compose up -d
docker-compose exec web rubocop
```

## Dockerfiles
`compose.yml` and `Dockerfile.dev` are used for local development  

`Dockerfile` is used for deployment to production

## TODO (didn't implement this due to time limitation):
- Add authentication (for example JWT)
- Implement role-based access control (only moderators should access these endpoints)
- Add `count` and `total_pages` to API responses
- Add user activity statistics (comment count, last activity)
- Add comment status (normal, deleted)
- Add `/api/v1/comments` API endpoint to select comments from a few authors
- Add filters for users (by username, email, registration date)
- Add search for comments (by content, date range)
- Add API endpoints for comment moderation
- Add rate limiting
