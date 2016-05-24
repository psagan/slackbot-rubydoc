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
