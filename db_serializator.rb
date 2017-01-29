require 'active_support/inflector'

DATATYPES = {
  "Char"      => "string"  ,
  "Integer"   => "integer" ,
  "Datetime"  => "datetime",
  "Text"      => "text"    ,
  "Date"      => "date"    ,
  "Time"      => "time"    ,
  "Binary"    => "boolean"
}

filepath = 'db.xml'
lines = IO.readlines(filepath)
tables = []

