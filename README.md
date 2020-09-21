# README

## Echo - code challenge for back-end developers

### System Requirements

* Ruby version 2.6 and above

* Rails version 5.2.4.3

### Assumption

Along with basic validations, I added `path` & `method`(HTTP Verb) uniqueness so that client could create duplicate endpoint.  


### Steps to run :

* Install dependencies

```
bundle install
```

* Database setup 

```
rake db:create

rake db:migrate
```
* Run server

```
rails s
```
** Run rests

```
rspec
```
