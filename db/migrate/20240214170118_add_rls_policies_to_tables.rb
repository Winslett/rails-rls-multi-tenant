class AddRlsPoliciesToTables < ActiveRecord::Migration[7.1]
  def up
    admin_database_uri = URI.parse(ENV['ADMIN_DATABASE_URL'])
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])

    postgres = ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: admin_database_uri.host,
      port: admin_database_uri.port,
      username: admin_database_uri.user,
      password: admin_database_uri.password,
      database: database_uri.path[1..-1]
    )

    postgres.connection.execute(<<SQL)
CREATE POLICY salesperson_contacts_policy ON contacts FOR ALL
	TO salesperson
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);

CREATE POLICY salesperson_opportunities_policy ON opportunities FOR ALL
	TO salesperson
USING (user_id = NULLIF(current_setting('rls.user_id', false), '')::integer);

CREATE POLICY salesperson_opportunity_contacts_policy ON opportunity_contacts FOR ALL
	TO salesperson
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);

CREATE POLICY salesperson_users_policy ON users FOR ALL
	TO salesperson
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);
SQL

    postgres.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, database_uri.password]))
CREATE POLICY salesmanager_contacts_policy ON contacts FOR ALL
	TO salesmanager
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);

CREATE POLICY salesmanager_opportunities_policy ON opportunities FOR ALL
	TO salesmanager
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);

CREATE POLICY salesmanager_opportunity_contacts_policy ON opportunity_contacts FOR ALL
	TO salesmanager
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);

CREATE POLICY salesmanager_users_policy ON users FOR ALL
	TO salesmanager
USING (team_id = NULLIF(current_setting('rls.team_id', false), '')::integer);
SQL

    postgres.connection.execute(<<SQL)
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE opportunities ENABLE ROW LEVEL SECURITY;
ALTER TABLE opportunity_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
SQL

    postgres.connection.execute(<<SQL)
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesperson;
GRANT ALL ON ALL TABLES IN SCHEMA public TO salesmanager;
SQL
  end

  def down
    admin_database_uri = URI.parse(ENV['ADMIN_DATABASE_URL'])
    database_uri = URI.parse(ENV['APP_DATABASE_URL'])

    postgres = ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: admin_database_uri.host,
      port: admin_database_uri.port,
      username: admin_database_uri.user,
      password: admin_database_uri.password,
      database: database_uri.path[1..-1]
    )

    postgres.connection.execute(<<SQL)
DROP POLICY salesperson_contacts_policy ON contacts;
DROP POLICY salesperson_opportunities_policy ON opportunities;
DROP POLICY salesperson_opportunity_contacts_policy ON opportunity_contacts;
DROP POLICY salesperson_users_policy ON users;
SQL

    postgres.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, database_uri.password]))
DROP POLICY salesmanager_contacts_policy ON contacts;
DROP POLICY salesmanager_opportunities_policy ON opportunities;
DROP POLICY salesmanager_opportunity_contacts_policy ON opportunity_contacts;
DROP POLICY salesmanager_users_policy ON users;
SQL

    postgres.connection.execute(<<SQL)
ALTER TABLE contacts DISABLE ROW LEVEL SECURITY;
ALTER TABLE opportunities DISABLE ROW LEVEL SECURITY;
ALTER TABLE opportunity_contacts DISABLE ROW LEVEL SECURITY;
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
SQL

  end

end
