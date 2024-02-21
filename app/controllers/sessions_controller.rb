class SessionsController < ApplicationController
  skip_before_action :set_rls_if_authenticated
  before_action :clear_rls

  def new
    self.current_user = User.find(params[:user_id])
    redirect_to team_path()
  end

  def destroy
    logout_current_user
    redirect_to root_url(), allow_other_host: true
  end

end
