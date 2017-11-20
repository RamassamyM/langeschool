class RegistrationsController < Devise::RegistrationsController

  def new
    if codecheck(code_params[:signin_code])
      @classroom = set_classroom(code_params[:signin_code])
      build_resource({})
      @child = @classroom.children.build
      @familylink = Familylink.new
      # self.resource.familylinks = Familylink.new
      respond_with self.resource
    else
      redirect_after_wrong_code
    end
  end

  def create
    super
    create_child_and_familylink
  end

  private

  def codecheck code
    Classroom.pluck(:signin_code).include?(code)
  end

  def redirect_after_wrong_code
    flash[:alert] = "Votre code n'est pas valide !"
    redirect_to codeinput_path
  end

  def set_classroom signin_code
    Classroom.where(signin_code: signin_code).first
  end

  def code_params
    params.require(:code).permit(:signin_code)
  end

  def create_child_and_familylink
  end

end
