
task :create_postgres_user do
    postgres = ActiveRecord::Base.establish_connection(ENV['ADMIN_DATABASE_URL'])
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])

    postgres.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, database_uri.password]))
CREATE ROLE salesperson;
CREATE ROLE salesmanager;

CREATE ROLE #{database_uri.user} WITH LOGIN CREATEDB PASSWORD ?;

GRANT salesperson TO #{database_uri.user};
GRANT salesmanager TO #{database_uri.user};
SQL
end

