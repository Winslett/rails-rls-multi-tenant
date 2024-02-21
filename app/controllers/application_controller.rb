class ApplicationController < ActionController::Base
  before_action :set_rls_if_authenticated

  DATABASE_URI = URI.parse(ENV['APP_DATABASE_URL'])

  def set_rls_if_authenticated

    ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, DATABASE_URI.user]))
RESET rls.team_id;
RESET rls.user_id;
SET ROLE ?;
SQL

    if current_user.present?
      ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, current_user.team_id, current_user.id, current_user.role]))
SET rls.team_id = ?;
SET rls.user_id = ?;
SET ROLE ?;
SQL
    end
  end

  def clear_rls
    ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array([<<SQL, DATABASE_URI.user]))
RESET rls.team_id;
RESET rls.user_id;
SET ROLE ?;
SQL
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:authenticated_user_id])
  end

  def current_user=(user)
    session[:authenticated_user_id] = user.id
  end

  def logout_current_user
    session.delete(:authenticated_user_id)
    session.destroy
  end
end
