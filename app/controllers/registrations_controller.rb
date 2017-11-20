class RegistrationsController < Devise::RegistrationsController
  before_action :set_user,
                :set_code,
                :set_child,
                :set_familylink,
                :codecheck,
                :set_classroom,
                :set_classroom_to_child,
                only: [:create]

  def new
    super do
      @child = Child.new
      @familylink = Familylink.new
    end
  end

  def create
    resource.save
    # yield resource if block_given?
    @child.save
    set_child_and_resource_to_familylink
    @familylink.save

    if resource.persisted? && @child.persisted? && @familylink.persisted?
      if resource.active_for_authentication?
        # set_flash_message! :notice, :signed_up
        flash[:notice] = "Veuillez cliquer sur le lien de confirmation de compte dans l'email que nous vous envoyons."
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        flash[:notice] = "Veuillez cliquer sur le lien de confirmation de compte dans l'email que nous vous envoyons."
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      @familylink.destroy && set_familylink if @familylink.persisted?
      @child.destroy && set_child if @child.persisted?
      resource.destroy && set_user if resource.persisted?
      render :new
    end
  end

  private

  def codecheck
    unless Classroom.pluck(:signin_code).include?(@code)
      @code = nil
      flash[:alert] = "Votre code n'est pas valide !"
      render :new
    end
  end

  def code_params
    params.require(:user).require(:code).permit(:signin_code)
  end

  def child_params
    params.require(:user).require(:child).permit(:first_name)
  end

  def familylink_params
    params.require(:user).require(:familylink).permit(:parental_link)
  end

  def set_code
    @code = code_params[:signin_code]
  end

  def set_classroom
    @classroom = Classroom.where(signin_code: @code).first if @code
  end

  def set_user
    build_resource(sign_up_params)
  end

  def set_familylink
    @familylink = Familylink.new(parental_link: familylink_params[:parental_link].to_i)
  end

  def set_child
    @child = Child.new(child_params)
  end

  def set_classroom_to_child
    @child.classroom = @classroom
  end

  def set_child_and_resource_to_familylink
    @familylink.child = @child
    @familylink.user = resource
  end

end
