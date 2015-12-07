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

Postmod is still pre-release, so you need to install it with:
```
$ gem install postmod --pre
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

Like most ruby projects, our new app has a few dependencies. Let's install them by running `bundle install`.

Run and deploy!
===

Apps created with Postmod are runnable and deployable from the start. You can start Greetings with `heroku local`, and check out `localhost:5000`. You will see a basic Chaplin app.
Chaplin is the micro-framework Postmod uses to port an api into a web app, but more on that later.

Now that we're made sure our app can run, let's deploy it to heroku.
```
git init
git commit -am "Initial commit"
```
