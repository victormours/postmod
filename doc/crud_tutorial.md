Setting up environment variables in Postmod
===

Postmod will create a Postgres role for your app, a database for the development environment, and a database for the test environment.

```
$ postmod create todolist
$ cd todolist
$ bundle install
$ psql -d postgres --command="create role todolist login createdb;"
$ bundle exec rake db:create
$ postmod generate/model lib/todolist/todo content:string status:string
$ bundle exec rake db:migrate
```

This is enough to take a look at the console:
```
$ bundle exec bin/console
```


```
$ heroku addons:create heroku-postgresql:hobby-dev
```

