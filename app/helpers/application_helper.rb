module ApplicationHelper

  def add_appropriate_navbar
    unless !(user_signed_in?) && is_home || user_credential_pages
      render 'shared/navbar'
    end
  end

  def add_appropriate_background
    if currentpage_belongs_to?([['conversations', 'show'], ['pages', 'subscribe'], ['pages', 'parentscouncil'], ['pages', 'schoolcouncil']])
      render 'layouts/background_colored', color: 'verylight-gray'
    else
      render 'layouts/background_pattern'
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

  def notification_class_if_seen_or_not(notification)
    if notification.is_seen
      'notification-box'
    else
      'notification-box notification-unseen'
    end
  end

  private

  def currentpage_belongs_to?(arrays_of_pages)
    arrays_of_pages.find do |controller_action|
      controller_name == controller_action[0] && action_name == controller_action[1]
    end
  end

  def user_credential_pages
    ['registrations', 'sessions', 'passwords', 'confirmations', 'unlocks'].include?(controller_name)
  end

  def is_home
    currentpage_belongs_to?([['pages', 'home']])
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

end
