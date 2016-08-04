# Moscavion [![Coverage Status](https://coveralls.io/repos/github/andela-tpeters/moscavion/badge.svg)](https://coveralls.io/github/andela-tpeters/moscavion) [![Build Status](https://travis-ci.org/andela-tpeters/moscavion.svg?branch=develop)](https://travis-ci.org/andela-tpeters/moscavion) [![Code Climate](https://codeclimate.com/repos/57a1e49ede8c777bf00001b0/badges/488dd4ac1628dfadcdfd/gpa.svg)](https://codeclimate.com/repos/57a1e49ede8c777bf00001b0/feed)


A flight booking application. Very seamless and quick

## Description
Flight Management System that enables users to search for available flights and book for them.

You can access the online application here [Moscavion](http://moscavion.herokuapp.com)

## Environment

### System dependencies
|        Backend                 |  Front-end                     |  Testing/Development
|--------------------------------|--------------------------------|------------------------------------------------------------
| Rails Framework                |   Semantic UI                  | RSpec + Factory Girl + Faker + Shoulda Matchers + SimpelCov
| PostgreSQL                     |   jQuery                       | Capybara
| Figaro                         |   Coffee Script                 | Letter Opener
| Puma server                    |                                | Guard


# Running the application

### Install dependencies

You need to install the following:

1. [Ruby](https://github.com/rbenv/rbenv)
2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
3. [Bundler](http://bundler.io/)
4. [Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
5. [RSpec](http://rspec.info/)


### Clone the repository

Clone the application to your local machine:

```
$ git clone https://github.com/andela-tpeters/moscavion.git
```

Install the dependencies

```
$ bundle install
```

Setup database and seed data

```
$ rake db:setup
```

To run the application;

```
$ rails s
```
Now visit `http://localhost:3000` to view the application on your prefered web browser.

