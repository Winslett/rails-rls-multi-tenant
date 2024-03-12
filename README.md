# To get started, you'll need the following:

1. `ADMIN_DATABASE_URL` -- an environmental variable with the pattern
   that looks like `postgres://user:pass@host:port/postgres`. This role does not need to be a superuser,
   but does need to have the ability to create new users.

2. `APP_DATABASE_URL` -- similar pattern to above, but a user does not need to exist yet, as it will be
   created by the following command. This will be the connection string used primarily by the application.
   The host and port should be the same as the `ADMIN_DATABASE_URL` above, but the database should be
   the one intended to be used by the application.

3. Run `rake db_roles:create_app_user`, which is a rake command in the
   `lib/tasks/db_roles.rake` file. This command will connect to the
   database using the `ADMIN_DATABASE_URL` and create the necessary
   application user.

4. Run `rails db:create` to create the database

5. Run `rake db_roles:create_nested_roles`, which will create roles for
   `salesperson` and `salesmanager`. Then, it will grant the ability for
   the app user to use those roles.

6. Run `rails db:migrate` or `rails db:schema:load` to build the
   database's data structures.  If you look at the migrations, you'll see
   how Row Level Security was implemented in an existing Rails
   application in the file
   `db/migrate/20240214170118_add_rls_policies_to_tables.rb`.

7. Run `rake db_roles:refresh` to rerun some `GRANT` statements after
   creating new tables in the database.

8. Run `rails db:seed` to add some data to the database.

9. Run `rails s` to start your app, and load the app in the browser.
   Click on the users to authenticate as those users and see how the
   queries change based on the roles and the settings.

## How it works

First, if you don't know about Postgres Row Level Security functionality, check
out this [Tutorial on Postgres Row Level Security](https://www.crunchydata.com/developers/playground/row-level-security).
This Rails application leverages the underlying database for this type
of technology.

### The Roles

This application uses three roles for the security:

1. `app_user` role which has access to all rows
2. `salesmanager` role which has access to all rows for a team
3. `salesperson` role which has access to all rows they are listed as
   the owner of

In the list of users above, `app_user` is least restrictive and
`salesperson` is most restrictive. Three tiers is a bit complex, but two
tiers would be common in a SaaS multi-tenant world where one role is the
end user and another role is an admin.

### Rails implementation

If you look in the `ApplicationController`, you will see `before_action
:set_rls_if_authenticated`.  The `set_rls_if_authenicated` method find
the current authenticated user and sets a variable on the Postgres
connection 

## Requires additional testing

**If you are using a connection pooler,**. connection poolers may
not maintain the same session settings for a specific command. Because
the sessions are set at the beginning of the controller action and not
directly adjacent to 

**If you are using asynchronous threads**, 



