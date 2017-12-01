class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :load_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :familylink, :child, :code])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  private

  def load_notifications
    if current_user
      @notification_badge_number = current_user.unseen_notifications_number
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:fully_registered] = false
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:fully_registered] = true
    posts_path
  end
end
