# Assestment JSON RESTful API

## Requirements

- [x] Implement functionality of depositing money into an ATM - the quantity of banknotes for each denomination is specified (for example, 10 in "50", 8 in "25", etc.). Denominations are: 1, 2, 5, 10, 25, 50.

- [x] Implement a method that accepts an amount for withdrawal and returns the set of required denominations and the quantities. If any ATM cassettes balance is insufficient for withdrawal, the user should be notified.

- [x] Transaction is canceled in case of insufficient balance.

For example, if there is an application to withdraw 200 UAH, and the cassettes balances are 3 in 50 and 4 in 25, then the result accepted results could read as follows: {50 => 3, 25 => 2} or {50 => 2, 25 => 4}.

- [x] The cassettes balances should be deducted accordingly.

- [x] Design the task in the form of a RESTful API. The framework is at the candidate's choice.

## Prototype Atm api

### Setup

Deploy mysql server in docker container

##### Requirements

- docker
- docker-compose
- localhost port 3306 not occupied and available for mapping
- Ruby 2.6.6, modify in Gemfile in order to use another 2.6.x version
- Bundler 2.0.1 preferred

##### Prepare and run in development environment

```bash
docker-compose up -d
docker-compose logs -f
bundle install
rake db:create
rake db:migrate
rackup
```

##### Prepare and run tests

```bash
docker-compose up -d
docker-compose logs -f
bundle install
RAILS_ENV=development rake db:create
RAILS_ENV=development rake db:migrate
rspec
```

According to above setting application runs at localhost:9292 by default.
Add port parameter to override the default port.

```
rackup -p 9292
```

### Endpoints

#### Health status endpoint

GET [api/v1/is_alive](http://localhost:9292/api/v1/is_alive "api/v1/is_alive")
Responds with status to 201 on success

#### Current ATM state

GET [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")
Responds with array of present denominations and their quantity, e.g:

```json
[
  {
    "denomination": 5,
    "quantity": 2
  }
]
```

#### Setup atm with payload

PUT [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")

```json
{
  "payload": {
    "denomination": 5,
    "quantity": 2
  }
}
```

Responds with status 201 on success.

#### Withdraw founds

POST [api/v1/atm/withdraw](http://localhost:9292/api/v1/atm/withdraw "api/v1/atm/withdraw")

```json
{
  "amount": 10
}
```

Responds with denominations ejected

```json
{
  "5": 2
}
```
