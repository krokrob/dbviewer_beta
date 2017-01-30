# DATATYPES = {
#   "CHAR"      => "string"  ,
#   "INTEGER"   => "integer" ,
#   "DATETIME"  => "datetime",
#   "TEXT"      => "text"    ,
#   "DATE"      => "date"    ,
#   "TIME"      => "time"    ,
#   "BINARY"    => "boolean"
# }

def serialize(filepath)
  lines = IO.readlines(filepath)
  tables = []
  table = {}
  row = {}
  lines.each do |line|
    if line =~/<table/
      table = { name: line.match(/name=\"(\w+)\"/)[1],
      x: line.match(/x=\"(\d+)\"/)[1],
      y: line.match(/y=\"(\d+)\"/)[1],
      rows: [] }
    elsif line =~ /<row/
      row_name = line.match(/name=\"(\w+)\"/)[1]
      pk = line =~ /autoincrement=\"1\"/ ? true : false
      row = { name: row_name, primary_key: pk }
    elsif line =~ /<datatypes/ && !(line =~ /db="mysql"/)
      row[:datatype] = line.match(/<datatypes>(\w+)<\/datatypes>/)[1]
    elsif line =~ /<default/
      row[:default_value] = line.match(/<default>(.+)<\/default>/)[1]
    elsif line =~ /<relation/
      row[:relation] = line.match(/<relation table=\"(\w+)\"/)[1]
    elsif line =~ /<\/row>/
      table[:rows] << row
    elsif line =~ /<\/table>/
      tables << table
      table = {}
    end
  end
  return tables
end


