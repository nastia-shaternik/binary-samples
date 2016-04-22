## Preparation

* run `bundle` to install gems
* copy database config `cp config/database.yml.example
  config/database.yml`
* create dev database `rails db:setup`
* create test database `rails db:test:prepare`
* run specs `rspec`

## API documentation

You can easily view API docs if you run server - `rails s` and then go
to `/api/docs`

## Optionally

BTW, you can create `.ruby-gemset` file in order to isolate this project
specific gems.
