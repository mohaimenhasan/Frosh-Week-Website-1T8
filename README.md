orientation.skule.ca
====================

Server and client code for orientation.skule.ca

## Development Setup
1.  Clone the repository.
1.  Use rvm to get ruby version 1.9.3.
1.  Download Postgres.app to run Postgres locally.
1.  Run `bundle` to install gems.
1.  Run `rake db:create` to create the databases.
1.  Create `.env` and set all the variables shown in `.env.sample`
1.  Run `foreman start` to start the server.
1.  Hack away.

## Code Style
-  2 spaces for indentation in JS and Ruby.
-  4 spaces for indentation in HTML, CSS.
-  Be consistent with what's already there.
-  Use single quotes for strings everywhere except when:
    - Single quotes are embedded in the string, i.e. "'Hello world', said the monster."
    - Variables are to be embedded in the string, i.e. "Hello #{world}"
    - HTML and CSS files. Double quotes should be used strictly for these files.
-  Follow the ruby style guide: https://github.com/bbatsov/ruby-style-guide
-  Follow the rails style guide: https://github.com/bbatsov/rails-style-guide
-  Use JSHint.
-  TODOs should take the following form in code: `// TODO(username): gotta do this thing`
