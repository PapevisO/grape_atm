# Atm api

## Setup
    bundle
	rake db:migrate
	rake db:test:prepare
	rspec
	rackup
By default application runs at localhost:9292

## Endpoints
### Alive probe 
GET [api/v1/is_alive](http://localhost:9292/api/v1/is_alive "api/v1/is_alive")
Responds with status to 201 on success
### Current ATM state
GET [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")
Responds with array of present nominals and their number, e.g:
```json
[
    {
        "nominal":5,
        "number":2
    }
]
```
### Setup atm with payload
PUT [api/v1/atm](http://localhost:9292/api/v1/atm "api/v1/atm")
```json
{
    "payload": {
        "nominal":5,
        "number":2
    }
}
```
Responds with status 201 on success.

### Withdraw founds
POST [api/v1/atm/withdraw](http://localhost:9292/api/v1/atm/withdraw "api/v1/atm/withdraw")
```json
{
    "amount":10
}
```
Responds with nominals ejected
```json
{
    "5": 2
}
```
