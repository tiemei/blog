class ApplicationController < ActionController::Base
  before_filter :require_login
  private
  def require_login
    if !session[:current_user_id]
      redirect_to '/login'
    end
  end
end
