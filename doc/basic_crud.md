Basic CRUD
===

Some applications only rely on external data stores to run, but most of them use a database with a structure adapted to their needs. Postmod facilitates working with Postgresql and Heroku.

If you've used Rails before, you're going to feel right at home with how Postmod interacts with the database.

In this tutorial, you'll learn to create a simple todolist app, which is going to be usable only from the console at first. In the second half of the tutorial, we'll see how to port that application to make it available as an api, and then as a web app.

For an overview of Postmod, take a look at the Getting started tutorial.


Prereqs
===

To follow along, you're gonna need to have postmod, postgres and the heroku toolbelt installed.

Creating the project
===

This is fairly straightforward:
```
$ postmod create todolist
$ cd todolist
$ bundle install
```

Creating the database and the first model
===

Postmod projects define their database configuration in the `db/` directory. For a brand new project, there is only a config.yml file.
This file will be familiar to anyone who's used Rails before. It defines how your app will connect to the database for your development and test environments. The production (and staging) configurations are defined automatically by Heroku.

Let's take a look at `db/config.yml`
```
development:
  adapter: postgresql
  encoding: utf8
  host: localhost
  username: todolist
  database: todolist_dev
  pool: 5
  timeout: 5000

test: &test
  database: todolist_test
  pool: 5
  timeout: 5000
```
By convention, Postmod expects a Postgres role for your app, a database for the development environment, and a database for the test environment.

Let's create this role:
```
$ psql -d postgres --command="create role todolist login createdb;"
```

And now let's create the database:
```
$ bundle exec rake db:create
```

Easy enough.


Now it's time to create our first model:
```
$ postmod generate/model lib/todolist/todo content:string done:boolean
```
This command creates a migration and a ruby model.


The new ActiveRecord migration will create the `todos` table with the columns `content` and `done`. This can be seen in the file in `db/migrate`:
```
class CreateTodo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :done
      t.timestamps :created_at
      t.timestamps :updated_at
    end
  end
end
```

Let's run that migration with
```
$ bundle exec rake db:migrate
```

In the `lib` directory, a new model was created as `lib/todolist/todo.rb`. It's pretty simple for now:
```
require 'active_record'

class Todolist::Todo < ActiveRecord::Base

end
```


Interacting with the database in the console
===

Postmod creates all new projects with a Pry console that allows interacting easily with all ruby files in the `lib` directory, including models.

Let's start the console:
```
$ bundle exec dotenv bin/console
```
You'll notice that we use the dotenv gem in order to load the environment variables defined in the `.env` file. By default this file is only populated with the `DATABASE_URL`. This allows us to connect to the database

We can already perform a couple of operations on our model:
```
pry(Todolist)> Todo.create(content: "Buy milk")
pry(Todolist)> Todo.all
pry(Todolist)> Todo.first.update(done: true)
pry(Todolist)> Todo.first.destroy
```

Connecting to the database on Heroku
===

Let's create a new heroku app:
```
$ git init
$ git add .
$ git commit -m "App setup"
$ heroku apps:create postmod-todolist
```

We need to install the postgres addon to have a database on heroku.
```
$ heroku addons:create heroku-postgresql:hobby-dev
```

We can now deploy and run the migration on heroku.
```
$ git push --set-upstream heroku master
$ heroku run bundle exec rake db:migrate
```

And now we can open a console on heroku to interact with the heroku database
```
$ heroku run bundle exec bin/console
```


Porting to the api
===

Let's modify the `api/api.rb` to make it look like this:
```
require_relative '../lib/todolist'
require 'grape'

ActiveRecord::Base.establish_connection

class Api < Grape::API

  get "/todos" do
    { todos: Todolist::Todo.all }
  end

  get "/todos/:id" do
    { todo: Todolist::Todo.find(params['id']) }
  end

  post "/todos" do
    {
      todo: Todolist::Todo.create(content: params['content'])
    }
  end

  put "/todos/:id" do
    todo = Todolist::Todo.find(params['id'])
    todo.update(params['todo'])
    { todo: todo }
  end

end
```

Now run `heroku local`, and let's send a couple of requests through the command line

```
$ bundle exec pry
pry(main)> require 'faraday'
pry(main)> require 'json'
pry(main)> JSON.parse Faraday.get('http://localhost:5000/api/todos').body
pry(main)> JSON.parse Faraday.post('http://localhost:5000/api/todos', {content: "Get milk"}).body
pry(main)> JSON.parse Faraday.get('http://localhost:5000/api/todos/1').body
pry(main)> JSON.parse Faraday.put('http://localhost:5000/api/todos', { todo: { done: 1 } }).body
pry(main)> JSON.parse Faraday.get('http://localhost:5000/api/todos/1').body
```

You can now commit, push to heroku, and run the same requests. You get the idea.

Porting to the web
===

Let's start by making the list available to the homepage.
Modify the `pages` section of the `web/app.yml` to map the index to the list of items:
```
pages:

  index.html:
    todos: GET todos
```

And then let's show these in the `templates/index.html`

```
<h1>Todo list</h1>
<ul>
{{#todos.todos}}
<li>
{{content}}
</li>
{{/todos.todos}}

</ul>
```

Now let's add a form at the bottom of the page to create a new item:
```
<form action="/todo" method="post">
  <label for="content">New item:</label>
  <input type="text" name="content" id="content"/>
  <div class="button">
    <button type="submit">Create</button>
  </div>
</form>
```

We'll need to modify the routes and redirect section of the `web/app.yml` to make this work:
```
routes:
  GET /: index.html
  POST /todo: redirect create


redirects:

  create:
    path: /
    requests:
      todo:
          - POST todos
          -
            content: "{{ content }}"


```
