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

```bash
bundle
rake db:create
rake db:migrate
rspec
rackup
```

According to above setting application runs at localhost:9292 by default.
Add port parameter to override the default port.

```
rackup -p 3000
```

### Endpoints

#### Health status endpoint

GET [api/v1/is_alive](http://localhost:3000/api/v1/is_alive "api/v1/is_alive")
Responds with status to 201 on success

#### Current ATM state

GET [api/v1/atm](http://localhost:3000/api/v1/atm "api/v1/atm")
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

PUT [api/v1/atm](http://localhost:3000/api/v1/atm "api/v1/atm")

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

POST [api/v1/atm/withdraw](http://localhost:3000/api/v1/atm/withdraw "api/v1/atm/withdraw")

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
