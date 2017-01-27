require 'active_support/inflector'
DATATYPES = {
  "string"    => "Char",
  "integer"   => "Integer",
  "datetime"  => "Datetime",
  "text"      => "Text",
  "date"      => "Date",
  "time"      => "Time"
}

def schema_parser(filepath)
  lines = IO.readlines(filepath)
  tables = []
  table = {}
  lines.each do |line|
    if line =~ /create_table/
      table = {}
      table[:name] = line.match(/\"(\w+)\"/)[1]
      table[:rows] = []
    elsif line =~ /\s+end\n/
      tables << table
      table = {}
    elsif line =~ /t\./
      unless line =~ /t\.index/
        table[:rows] << { name: line.match(/\"(\w+)\"/)[1], datatype: line.match(/t\.(\w+)\s+\"/)[1] }
      end
    end
  end
  return tables
end

def generate_xml_db(tables)
  db = ""
  tables.each do |table|
    db += generate_xml_table(table)
  end
  return '<?xml version="1.0" encoding="utf-8" ?>
<!-- SQL XML created by WWW SQL Designer, http://code.google.com/p/wwwsqldesigner/ -->
<!-- Active URL: http://db.lewagon.org/ -->
<sql>
<datatypes db="mysql">
  <group label="Numeric" color="rgb(238,238,170)">
    <type label="TINYINT" length="0" sql="TINYINT" quote=""/>
    <type label="SMALLINT" length="0" sql="SMALLINT" quote=""/>
    <type label="MEDIUMINT" length="0" sql="MEDIUMINT" quote=""/>
    <type label="INT" length="0" sql="INT" quote=""/>
    <type label="Integer" length="0" sql="INTEGER" quote=""/>
    <type label="BIGINT" length="0" sql="BIGINT" quote=""/>
    <type label="Decimal" length="1" sql="DECIMAL" re="DEC" quote=""/>
    <type label="Single precision" length="0" sql="FLOAT" quote=""/>
    <type label="Double precision" length="0" sql="DOUBLE" re="DOUBLE" quote=""/>
  </group>

  <group label="Character" color="rgb(255,200,200)">
    <type label="Char" length="1" sql="CHAR" quote="\'"/>
    <type label="Varchar" length="1" sql="VARCHAR" quote="\'"/>
    <type label="Text" length="0" sql="MEDIUMTEXT" re="TEXT" quote="\'"/>
    <type label="Binary" length="1" sql="BINARY" quote="\'"/>
    <type label="Varbinary" length="1" sql="VARBINARY" quote="\'"/>
    <type label="BLOB" length="0" sql="BLOB" re="BLOB" quote="\'"/>
  </group>

  <group label="Date &amp; Time" color="rgb(200,255,200)">
    <type label="Date" length="0" sql="DATE" quote="\'"/>
    <type label="Time" length="0" sql="TIME" quote="\'"/>
    <type label="Datetime" length="0" sql="DATETIME" quote="\'"/>
    <type label="Year" length="0" sql="YEAR" quote=""/>
    <type label="Timestamp" length="0" sql="TIMESTAMP" quote="\'"/>
  </group>

  <group label="Miscellaneous" color="rgb(200,200,255)">
    <type label="ENUM" length="1" sql="ENUM" quote=""/>
    <type label="SET" length="1" sql="SET" quote=""/>
    <type label="Bit" length="0" sql="bit" quote=""/>
  </group>
</datatypes>
' + db + '
</sql>'
end

def generate_xml_table(table)
  rows = ""
  table[:rows].each do |row|
    rows += generate_xml_row(row)
  end

  return "
<table x=\"0\" y=\"0\" name=\"#{table[:name]}\">
  <row name=\"id\" null=\"1\" autoincrement=\"1\">
    <datatype>TINYINT</datatype>
    <default>NULL</default>
  </row>
  " + rows + "
  <key type=\"PRIMARY\" name=\"\">
    <part>id</part>
  </key>
</table>
"
end

def generate_xml_row(row)
  datatype = pg_to_xml_datatypes(row[:datatype])
  if datatype == "Integer" && row[:name] =~ /\w+_id$/
    relation = row[:name].match(/(\w+)_id/)[1].pluralize
    xml_relation = "<relation table=\"#{relation}\" row='id' />"
  else
    xml_relation = ""
  end
  return "<row name=\"#{row[:name]}\" null='1' autoincrement='0'>
    <datatype>#{datatype}</datatype>
    <default>NULL</default>
    " + xml_relation + "
  </row>
  "
end

def pg_to_xml_datatypes(datatype)
  xml_datatype = DATATYPES[datatype]
  return xml_datatype ? xml_datatype : "TINYINT"
end

