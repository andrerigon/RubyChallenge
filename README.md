# RubyChallenge

[View live on Heroku](https://ruby-challenge.herokuapp.com/)

Simple App to access Fyber's API and render some offers information.

## Assumptions:

1) Sinatra was chosen due to its simplicity, since no latency, throughput or load requisites were given.
2) Config is hardwired into a module. If the app demands more complexity and configuration options to access the API, it could be moved to a file.
3) Views are simple erb files, with the only purpose to see sample offers. For a real app, the css must be removed from erb, and the assets be obtained locally and versioned.
4) Some HTML5 features (ex: number field) may not be supported in old browsers
5) RVM is used to manage ruby versions and gem sets.

## Install  gems:

make setup

## Running the app:

make run

## Running tests:

rake







