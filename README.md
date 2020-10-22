# GitTrendex

INSTRUCTIONS

- install docker and docker-compose
- copy .env.dist > .env and fill values
- docker-compose build
- docker-compose up 
- wait until image compilation is complete 

  Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
  your db is available on localhost:5433

- running tests 
   go to app dir
    
  1. mix test_unit - no enviroment required. Can be started on any machine with erlang and elixir installed

  2. integration test have to use enviroment
     docker-compose run web /bin/bash
     MIX_ENV=test mix test_integration
     
     you can also run a unit tests here
     MIX_ENV=test mix test_unit

  4. test coverage (integration tests)

     docker-compose run web /bin/bash

  5. to run coverage for unit tests, change in mix.exs
   test_coverage: [tool: ExCoveralls, test_task: "test_integration"]
   "test_integration" to "test_unit"

  6. check out app config to determine timeouts of refresh

======================
BROWSER INTERFACE


testing through http json api

localhost:4000/ - list all repos
localhost:4000/sync - start syncing 
localhost:4000/show?id=123 - show repo with id=123 
localhost:4000/show?name=123- show repo with name=123 

======================
CLI INTERFACE


A simple cli client was built with escript. It uses erlang rpc remote calls on running main node

running client
  client app is placed in same container as main application, for simplicity. So, we have to start application first
  1. docker-compose up 
  2. then open a new terminal window and run bash on container
      docker-compose exec   web /bin/bash
  3. run client
  ./git_trendex    
   
   no args - show help
    
     --all - get all trending repos

     --sync - update repos with github trending

     --name 123  - get repo by name

     --id 123  - get repo by id 
    
    example
    ./git_trendex --name 123
    ./git_trendex --sync
    ./git_trendex --all


