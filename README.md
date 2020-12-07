# Goroda

Roda + Sequel Stack for REST API implement in ruby.

## Setting up

1. Clone this repository:

```
  git clone git@github.com:tranquangvu/goroda.git
  mv goroda my_api
  cd my_api
```

2. Install ruby and gems

```
  rbenv local 2.7.2
  bundle install
```

3. Add `.env.#{environment}` file, example for `.env.development` file:

```
  DB_ENCODING=utf8
  DB_HOST=localhost
  DB_PORT=5432
  DB_USER=postgres
  DB_PASSWORD=
  DB_NAME=goroda_development
  DB_MAX_CONNECTIONS=10
```

4. Run migration:

```
  bundle exec rake db:migrate
```

5. Start server:

```
  rackup -> # Use puma as http server by defaut
  rackup -s webrick -> # Use webric as http server
```

Server will be start on `http://localhost:9292`

## Databases

This boilerplate use `postgres` as default database. You can change it by modifying adapter value in `db.rb` file.

- Run `rake db:create` to create database:

```
  # create database for development environment (use credentials in .env.development file)
  bundle exec rake db:create

  # create database for test environment (use credentials in .env.test file)
  RACK_ENV=test bundle exec rake db:create

  # create database for production environment (use credentials in .env.production file)
  RACK_ENV=production bundle exec rake db:create
```

- Run `rake db:drop` to drop database:

```
  bundle exec rake db:drop
  RACK_ENV=test bundle exec rake db:drop
  RACK_ENV=production bundle exec rake db:drop
```

- Run `rake db:migrate` to run migrations:

```
  bundle exec rake db:migrate
  RACK_ENV=test bundle exec rake db:migrate
  RACK_ENV=production bundle exec rake db:migrate
```

- Run `rake db:rollback` to rollback to previous migrations:

```
  bundle exec rake db:rollback # -> Rollback to previous migration version
  bundle exec rake db:rollback[version_number_here] # -> Rollback to specific migration version

  RACK_ENV=test bundle exec rake db:rollback
  RACK_ENV=production bundle exec rake db:rollback
```

- Run `rake db:version` to get current migration version:

```
  bundle exec rake db:version
  RACK_ENV=test bundle exec rake db:version
  RACK_ENV=production bundle exec rake db:version
```

## Console

Support to load all models class, much more easier to debug your app. If your need to loads more things than models, you can modify `lib/tasks/console.rake`

```
  bundle exec rake console
  // or
  bundle exec rake c

  RACK_ENV=test bundle exec rake console
  RACK_ENV=production bundle exec rake console
```

## Debugger

Use `byebug` as default debugger tool, please read `byebug` document to see how to use.

## Todos

- Add Rspec as testing tool
- Add controllers and serializers
- User authentication with JWT
- Config mailer
