#!/bin/bash

#Install latest version of postgresql
brew install postgres

#Service postgresql should be started before use.
brew services start postgresql

#Verify that PostgreSQL is ready for accept incoming connections.
# exit codes:
# ready - 0
# reject - 1
# connection timeout - 2
# incorrect credentials or parameters - 3
pg_isready

#Stop postgresql
brew services stop postgresql