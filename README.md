# ixplora-api-tests

API testing automation framework for ixplora API developed by team A of AT-04 group.

## Pre-requirements

* Ruby 2.4.x 
* Bundler Gem
* MongoDB 3.x server (preconfigured)
* CassandraDB 3.x server (preconfigured)
* Ixplora API server

## Setup

1. Clone the repository

```
https://github.com/RichardSeverich/ruby-automation-api-ixplora.git
```

2. Enter to the ixplora-api-test folder and run the command:

```
bundler install
```

3. Edit the env.rb file with the environment configuration properties. The env.rb file and the example is located in:

```
ixplora-api-tests/features/support/
```

4. To run the tests enter to the ixplora-api-test folder and run the command:

```
rake reports['{tag}']
```

{tag} can take the values: smoke, crud and functional. E.g: rake reports['smoke']
