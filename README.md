orientation.skule.ca
====================

Server and client code for orientation.skule.ca

## Development Setup
1.  Clone the repository.
2.  Use rvm to get ruby version 1.9.3.
3.  Download Postgres.app to run Postgres locally.
4.  Run `bundle` to install gems.
5.  Run `rake db:create` to create the databases.
6.  Run `rails server` to start the server.
7.  Hack away.

## Code Style
1.  2 spaces for indentation.
2.  Be consistent with what's already there.

## API
#### Working endpoints (Open issues for these if there's something you need changed)
- POST /api/people
- GET /api/people/ID
- GET /api/people
- DELETE /api/people/ID
