# To get started, you'll need the following:

1. An `ADMIN_DATABASE_URL` -- this role does not need to be a superuser,
   but does need to have the ability to create new users.

2. Create an `APP_DATABASE_URL` with the user that you intend to connect
   to the database with.  The host and port should be the same as the
   `ADMIN_DATABASE_URL` above.

3. Run `rake create_postgres_user`, which will create the proper
   database user with the proper settings.
