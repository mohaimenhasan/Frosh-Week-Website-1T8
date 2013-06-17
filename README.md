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
1.  2 spaces for indentation in JS and Ruby.
2.  4 spaces for indentation in HTML, CSS.
3.  Be consistent with what's already there.
4.  Use single quotes for strings everywhere except when:
    1.  Single quotes are embedded in the string, i.e. "'Hello world', said the monster."
    2.  Variables are to be embedded in the string, i.e. "Hello #{world}"
    3.  HTML and CSS files. Double quotes should be used strictly for these files.
5.  Follow the ruby style guide: https://github.com/bbatsov/ruby-style-guide
6.  Follow the rails style guide: https://github.com/bbatsov/rails-style-guide
7.  Use JSHint.
8.  TODOs should take the following form in code: `// TODO(username): gotta do this thing`
