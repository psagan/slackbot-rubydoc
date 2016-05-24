# slackbot-rubydoc  [![Build Status](https://travis-ci.org/psagan/slackbot-rubydoc.svg?branch=master)](https://travis-ci.org/psagan/slackbot-rubydoc) [![Code Climate](https://codeclimate.com/github/psagan/slackbot-rubydoc/badges/gpa.svg)](https://codeclimate.com/github/psagan/slackbot-rubydoc)
Slack bot for providing ruby documentation from ri CLI tool

## How to start using bot
Please clone the repository. Go to cloned directory and run:
 ```
 script/setup
 ==> Installing gem dependencies…
 ==> Bot is now ready to start! :)
 ```
Then you are ready to start the bot:
```
script/server
==> Installing gem dependencies…
==> Bot started watching the Slack
```

## About code design
Application is written with Single Responsibility in mind and TRUE heuristic (Sandi Metz rules).
Code starts in **run.rb** file - which has simple configuration like host, destination_directory, redis_connection params and number of threads.

**run.rb** is responsible for knowing what to instantiate. I use Dependency Injection and aggregation approach.
In **run.rb** I inject all stuff to main execution object **"Client::Fye"** which is responsible for running proper steps in **#run** method.
 
Classes have corresponding tests in spec directory. To run tests please type (being in app's directory):
 ```
 script/test
 ```
## About dependencies I had used
One of the goals is to not use lot of external dependencies.
The easies way is to just use https://github.com/dblock/slack-ruby-bot but it has lot of external
dependencies like ActiveSupport etc. On the other hand if we can live with that dependencies I recommend to
use this gem as it works really nice and is easy in implementation and is actively developed and supported. 
**My bot from lib/bot is reusable and also works nice with slack-ruby-bot gem.** :)

Ok, I did some job to not use **slack-ruby-bot** and I'm using **faye-websocket** to communicate with websocket
just to not reinvent the wheel and do not write all the websocket communication code on my own ;P (to keep
healthy balance between what to use as dependency and what to write on my own).  Faye-websocket provides nice
interface for websocket client and is based on battle-tested library EventMachine.
Other dependencies I use are of course:
* **rake**
* **rspec** 