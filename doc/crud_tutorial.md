Setting up environment variables in Postmod
===

Postmod will create a Postgres role for your app, a database for the development environment, and a database for the test environment.

```
$ postmod create todolist
$ cd todolist
$ bundle install
$ psql -d postgres --command="create role todolist login createdb;"
$ bundle exec rake db:create
$ postmod generate/model lib/todolist/todo content:string done:bool
$ bundle exec rake db:migrate
```

This is enough to take a look at the console:
```
$ bundle exec dotenv bin/console
```

```
pry(Todolist)> Todo.create(content: "Buy milk")
pry(Todolist)> Todo.all
pry(Todolist)> Todo.first.update(done: true)
pry(Todolist)> Todo.first.destroy
```


```
$ git init
$ git add .
$ git commit -m "App setup"
$ heroku apps:create postmod-todolist
$ heroku addons:create heroku-postgresql:hobby-dev
$ git push --set-upstream heroku master
$ heroku run bundle exec rake db:migrate
$ heroku run bundle exec bin/console
```

