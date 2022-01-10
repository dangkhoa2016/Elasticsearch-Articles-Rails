def insert(xxx)
  puts "save migration version: #{xxx}"
  ActiveRecord::Base.connection.execute("insert into schema_migrations (version) values (#{xxx})") rescue nil
end

files = Dir.glob("db/migrate/*")
files.collect { |f| f.split("/").last.split("_").first }.map { |n| insert(n) }
