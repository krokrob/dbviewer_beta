class Router
  def run
    display_menu
    print "> "
    choice = gets.chomp.to_i

    case choice
    when 1
      puts 'Enter your schema.rb filepath:'
      print '> '
      filepath = gets.chomp
      tables = schema_parser(filepath)
      db = generate_xml_db(tables)
      File.open('.xml', 'wb') { |file| file.write(db) }
    when 2
      puts 'Enter your $YOUR_XML_FILE.xml filepath'
      print '> '
      filepath = gets.chomp
      p serialize(filepath)
    end
  end

  def display_menu
    puts "Welcome to DBviewer"
    puts ""
    puts "1. Visualize your DB"
    puts "2. Serialize your DB"
  end
end
