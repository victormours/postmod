Setting up environment variables in Postmod
===

Postmod will create a Postgres role for your app, a database for the development environment, and a database for the test environment.

```
$ postmod create todolist
$ cd todolist
$ bundle install
$ bundle exec rake db:create
$ postmod generate/model lib/todolist/todo content:string status:string
$ bundle exec rake db:migrate
```


```
$ heroku addons:create heroku-postgresql:hobby-dev
```

