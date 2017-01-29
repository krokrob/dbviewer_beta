require 'active_support/inflector'

DATATYPES = {
  "CHAR"      => "string"  ,
  "INTEGER"   => "integer" ,
  "DATETIME"  => "datetime",
  "TEXT"      => "text"    ,
  "DATE"      => "date"    ,
  "TIME"      => "time"    ,
  "BINARY"    => "boolean"
}

filepath = 'db.xml'
lines = IO.readlines(filepath)
tables = []

