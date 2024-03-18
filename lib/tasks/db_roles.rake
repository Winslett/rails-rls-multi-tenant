namespace :db_roles do
  task :create_app_user do
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])
    admin_database_uri = URI.parse(ENV['ADMIN_DATABASE_URL'])

    admin_postgres = ActiveRecord::Base.establish_connection(
      host: admin_database_uri.host,
      port: admin_database_uri.port,
      user: admin_database_uri.user,
      password: admin_database_uri.password,
      dbname: admin_database_uri.path[1..-1],
      adapter: 'postgresql')

    sql = if database_uri.password.present?
            ActiveRecord::Base.sanitize_sql_array(["CREATE ROLE #{database_uri.user} WITH LOGIN CREATEDB PASSWORD ?;", database_uri.password])
          else
            "CREATE ROLE #{database_uri.user} WITH LOGIN CREATEDB;"
          end

    admin_postgres.connection.execute(sql)

    puts "Created user #{database_uri.user}"
  end


  task :create_nested_roles do
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

    postgres.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, database_uri.user]))
GRANT salesperson TO #{database_uri.user};
GRANT salesmanager TO #{database_uri.user};
SQL

    postgres.connection.execute(<<SQL)
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesperson;
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesmanager;
SQL

    puts "Created roles salesperson and salesmanager"
  end

  task :refresh_permissions do
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])
    admin_database_uri = URI.parse(ENV['ADMIN_DATABASE_URL'])

    postgres = ActiveRecord::Base.establish_connection(
      host: admin_database_uri.host,
      port: admin_database_uri.port,
      user: admin_database_uri.user,
      password: admin_database_uri.password,
      dbname: database_uri.path[1..-1],
      adapter: 'postgresql')

    postgres.connection.execute(<<SQL)
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesperson;
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesmanager;
SQL

    puts 'Permission refreshed on all tables for salesperson and salesmanager'
  end

end
