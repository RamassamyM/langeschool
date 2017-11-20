module ApplicationHelper

  def add_appropriate_navbar
    unless !(user_signed_in?) && is_home || user_credential_pages
      render 'shared/navbar'
    end
  end

  def relative_time(datetime_before)
    diff_seconds = (Time.now - datetime_before).round
    case diff_seconds
      when 0 .. 59
        "il y a #{diff_seconds} secondes"
      when 60 .. 3599
        "il y a #{diff_seconds/60.round} minute(s)"
      when 3600 .. 86399
        "il y a #{diff_seconds/3600.round} heure()s"
      when 86400 .. 2592000
        "il y a #{ diff_seconds / 86400.round } jour(s)"
      else
        datetime_before.strftime("%m-%e-%y %H:%M")
    end
  end

  def dynamic_avatar user
    if user.avatar?
      ActionController::Base.helpers.cl_image_path user.avatar.path
    else
      image_path "user.png"
    end
  end

  private

  def user_credential_pages
    (controller_name == 'registrations') || (controller_name == 'sessions') || (controller_name == 'passwords') || (controller_name == 'confirmations') || (controller_name == 'unlocks')
  end

  def is_home
    controller_name == "pages" && ( action_name == "home")
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

end
