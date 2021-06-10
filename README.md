# Assestment JSON RESTful API

## Requirements

- [ ] There should be a function of depositing money into an ATM - the number of bills of each denomination is sent (for example, 10 bills by "50", 8 by "25", etc.). Denominations are: 1, 2, 5, 10, 25, 50.

- [ ] Implement a method that accepts an amount for issue and returns the required denominations. If the ATM does not have enough money for issuing, the user should receive a message about this.

For example, if there is a request for the issue of UAH 200, and there are 3 bills of 50 and 4 of 25 in stock, then the result may be as follows: {50 => 3, 25 => 2} or {50 => 2, 25 => four}.

- [ ] The amount of money on hand should decrease after each issue.

- [ ] Design the task in the form of a RESTful API. The framework is at the candidate's choice.

## Prototype Atm api

### Setup

    bundle
    rake db:migrate
    rake db:test:prepare
    rspec
    rackup

By default application runs at localhost:9292

### Endpoints

#### Alive probe

GET [api/v1/is_alive](http://localhost:9292/api/v1/is_alive "api/v1/is_alive")
Responds with status to 201 on success

#### Current ATM state

GET [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")
Responds with array of present nominals and their number, e.g:

```json
[
  {
    "nominal": 5,
    "number": 2
  }
]
```

#### Setup atm with payload

PUT [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")

```json
{
  "payload": {
    "nominal": 5,
    "number": 2
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

Responds with nominals ejected

```json
{
  "5": 2
}
```
