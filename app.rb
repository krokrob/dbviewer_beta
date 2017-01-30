require 'active_support/inflector'
require_relative 'db_generator'
require_relative 'db_serializator'
require_relative 'router'

Router.new.run

