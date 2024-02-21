
task :create_postgres_user do
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])
    admin_database_uri = URI.parse(ENV['ADMIN_DATABASE_URL'])

    postgres = ActiveRecord::Base.establish_connection(
      host: admin_database_uri.host,
      port: admin_database_uri.port,
      user: admin_database_uri.user,
      password: admin_database_uri.password,
      dbname: database_uri.path[1..-1],
      adapter: 'postgresql')

    begin
      postgres.connection.execute("CREATE ROLE salesperson;")
    rescue ActiveRecord::StatementInvalid
      puts "Role salesperson already exists."
    end

    begin
      postgres.connection.execute("CREATE ROLE salesmanager;")
    rescue ActiveRecord::StatementInvalid
      puts "Role salesperson already exists."
    end

    begin
      postgres.connection.execute("CREATE ROLE #{database_uri.user} WITH LOGIN CREATEDB PASSWORD ?;")
    rescue ActiveRecord::StatementInvalid
      puts "Role salesperson already exists."
    end


    puts postgres.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, database_uri.user]))
GRANT salesperson TO #{database_uri.user};
GRANT salesmanager TO #{database_uri.user};
SQL

    puts postgres.connection.execute(<<SQL)
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesperson;
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesmanager;
SQL

    postgres.connection.execute("SELECT * FROM users;")

end

