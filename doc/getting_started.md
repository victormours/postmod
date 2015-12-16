Getting started with Postmod
===

Postmod is an experimental project trying to find a satisfying and easy way to create applications for the web and beyond. I've started working on it after many years of wishing Rails did not have the shortcomings explained in Uncle Bob's Architecture: The lost years (go see it if you haven't already), and trying to find something better than starting every new project from scratch.

Postmod is based on a couple of ideas:
- Applications are stateless, and have domain-specific logic that allows users to read and write to data stores in an organized way.
- The means that an application is accessed is called a medium. It can be the web, a command line, a code library, email, whatever. An application available on one medium can be made available on an other medium by porting it. Uncle Bob criticizes Rails for being too tied to the web, which is the default medium for most Rails apps. All applications have an original medium. Postmod doesn't try to hide that truth, but only to choose the medium from which porting is the easiest: raw code; and then making porting easy. For example, Chaplin is used to port json api's into web apps.
- Postmod is a facilitator, not a dependency. Projects build with Postmod do not need to know anything about Postmod. Postmod will not appear in the Gemfile, except maybe as a development gem.


This tutorial will take you through the steps of building a basic Hello world app and deploying it to Heroku.

Prereqs
===

To follow along, you're gonna need to have a recent version of ruby and the heroku toolbelt installed.

Installing
===

Let's get started! Install Postmod with this command
```
$ gem install postmod
```


Creating a new project
===

Let's say we're gonna work on a project called Greetings, that says hello to people.
Create a new project like this:
```
$ postmod create greetings
```

this creates a new directory called `greetings` with a couple of configuration files, and a subdirectory for each medium our app is going to be ported to.

Install the app
===

Like most ruby projects, our new app has a few dependencies. Let's install them:
```
$ cd greetings
$ bundle install
```

Run and deploy!
===

Apps created with Postmod are runnable and deployable from the start. You can start Greetings with `heroku local`, and check out `localhost:5000`. You will see a basic Chaplin app.
Chaplin is the micro-framework Postmod uses to port an api into a web app, but more on that later.

Now that we're made sure our app can run, let's deploy it to heroku.
```
$ git init
$ git add .
$ git commit -m "Setup project"
$ heroku apps:create postmod-greetings # This app name is probably already taken, feel free to chose another one
$ git push --set-upstream heroku master
```
The deploy will take a few moments, and then you'll be able to see your app online with `heroku open`

And now the real stuff
===

Alright! Time to get some work done. As you may have noticed, your app has three layers: a plain Ruby module defined in `lib/greetings.rb`, an api defined in `api/api.rb`, and web app in `web/app.yml`.
For each feature, we're going to start by defining it in the ruby module, and then work our way up as needed.

For now, let's create a new ruby class
```
$ postmod generate/action lib/greetings/hello
```
This creates a new action: a ruby class with just a `.call` method. Let's open `lib/greetings/hello.rb` in your editor of choice. This is what is looks like:
```
class Greetings::Hello

  def self.call
  end

end
```

Using the call method is a Postmod convention: actions that make sense for the user should be classes that can be called as is.
Let's fill in that method like this:
```
class Greetings::Hello

  def self.call
    { hello: "Hello world!" }
  end

end
```

So now we could use greetings as a ruby library and greet people. Nothing remarkable. Let's port that feature to the api.

The api is defined in `api/api.rb` like this:
```
require_relative '../lib/greetings'
require 'grape'

class Api < Grape::API
end
```

Let's edit it like this:

```
require_relative '../lib/greetings'
require 'grape'

class Api < Grape::API

  get '/hello.json' do
    Greetings::Hello.().to_json
  end

end
```

And now let's start the api like this
```
$ cd api
$ bundle exec rackup
```
And you can see the result at `localhost:9292/hello.json`.

Alright, now time to make this available through the web app. Let's take a look at the Chaplin declaration file, in `web/app.yml`

```
api_url: "http://localhost:{{env.PORT}}/api"

layout: layout.html

404: 404.html

routes:
  GET /: index.html
  GET /about: about.html
  GET /redirect_to_about: redirect go_to_about_page


pages:

  about.html:
    repo: GET repos/victormours/chaplin


redirects:

  go_to_about_page:
    path: /about
    requests: {}

```

The interesting thing here is that the web app calls the api server-side to get the json data it will use to render the templates. This allows to completely decouple application logic from HTML presentation.
Let's remove some of the default Chaplin stuff and make the file look like this:
```
api_url: "http://localhost:{{env.PORT}}/api"

layout: layout.html

404: 404.html

routes:
  GET /: index.html
  GET /hello: hello.html

pages:

  hello.html:
    greeting: GET hello.json

```

Now we need to create the template file. This will do it:
```
$ echo "{{greeting.hello}}" > web/templates/hello.html
```

And start the application again with `heroku local`
Now navigate to `localhost:5000/hello` and voilà!

Time to deploy to heroku:
```
$ git add .
$ git commit -m "Say hello"
$ git push heroku
$ heroku open
```


That's it!
===

To take things one step further, check out the tutorial on crud.
