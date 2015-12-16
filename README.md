Postmod
===

## Post-modern application development

Postmod is an experimental project trying to find a satisfying and easy way to create applications for the web and beyond.

I've started working on it after many years of wishing Rails did not have the shortcomings explained in Uncle Bob's [Architecture: The lost years](https://www.youtube.com/watch?v=WpkDN78P884) (go see it if you haven't already), and looking for a more sustainable workflow than starting every new project from scratch.

## Philosophy

* Postmod is a facilitator, not a framework. Your app will not depend on Postmod (except maybe as a development dependency).
* Apps are built as a plain Ruby library, and then are possibly ported into JSON apis, which are connected to web apps. Or maybe they are just ported into workers. Or maybe compiled into Javascript using Opal. I don't know, do whatever you want. Postmod facilitates porting Ruby libraries into apis with [Grape](https://github.com/ruby-grape/grape), and turning apis into web apps with [Chaplin](https://github.com/victormours/chaplin). Call it the decorator pattern or layered architecture, the point is that the web or whatever medium you use to deliver your app doesn't interfere with your core code.
* ActiveRecord and postgres are still pretty sweet. Postmod facilitates setting up Postgres databases and accessing them with ActiveRecord.


## Quickstart
```
$ gem install postmod
$ postmod new helloworld
$ cd helloworld
$ bundle install
$ git init
$ git commit -am "App setup"
$ heroku apps:create helloworld
$ git push --set-upstream heroku master
```

Done!
[Check out the tutorials](https://github.com/victormours/postmod/tree/master/doc) for how to build some basic apps.

## Contributing

If you spot a bug, a spelling mistake, something that could be improved in the docs, you're very welcome to send a pull request!
For more involved contributions, let's talk on Twitter. I'd be super happy to collaborate with you. :)

This is under the MIT license btw.


