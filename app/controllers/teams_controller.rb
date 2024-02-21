class TeamsController < ApplicationController

  def index
    @teams = Team.all

    @postgres_user = ActiveRecord::Base.connection.execute("SELECT current_user;").first["current_user"]
    @postgres_sql = @teams.to_sql
  end

  def show
    @team = current_user.team

    @users = User.all
    @postgres_user_sql = User.all.to_sql

    @opportunities = Opportunity.all
    @postgres_opportunities_sql = Opportunity.all.to_sql

    @contacts = Contact.all
    @postgres_contacts_sql = Contact.all.to_sql

    @postgres_user = ActiveRecord::Base.connection.execute("SELECT current_user;").first["current_user"]
  end

end
