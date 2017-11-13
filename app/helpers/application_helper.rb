module ApplicationHelper

  def add_appropriate_navbar
    unless !(user_signed_in?) && is_home || user_credential_pages
      render 'shared/navbar'
    end
  end

  private

  def user_credential_pages
    (controller_name == 'registrations') || (controller_name == 'sessions') || (controller_name == 'passwords')
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
