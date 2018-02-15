class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  include CanCan::ControllerAdditions
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

  def render_404
    redirect_to main_app.root_url, status: 404
  end
end
