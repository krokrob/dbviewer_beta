require_relative 'db_generator'

puts 'Enter your schema.rb filepath:'
print '> '
filepath = gets.chomp
tables = schema_parser(filepath)
db = generate_xml_db(tables)
File.open('db.xml', 'wb') { |file| file.write(db) }

