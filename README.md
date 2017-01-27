# DBviewer

DBviewer is a simple tool to read a Rails' `schema.rb` file and create an `XML` file representing a database schema readable on [db.lewagon.org](http://db.lewagon.org).

This can be useful when joining a huge existing Rails project with no DB representation. 

## Pre-requisites

The program needs `ActiveSupport` to run so:

```ruby
gem install activesupport
```

## Usage

1. Clone the repo and launch `app.rb`. 
2. You must enter the filepath to a `schema.rb` file. 
3. Resulting `db.xml` file is available at the root of the cloned repo.
4. Copy the `db.xml` content and go to [db.lewagon.org](http://db.lewagon.org).
5. Click on `Save / Load` button on the left sidebar and paste the `XML` code.
6. Click on `Load XML` button.
7. Replace tables as you wish.
8. Enjoy the view :eyes: !

## Contribution

Fork, clone, improve, pull.

## Version

Compatible with: 

- Ruby 2.4.0
- Rails 5.0
