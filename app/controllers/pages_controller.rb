class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legalterms, :codeinput, :codecheck]

  def home
  end

  def parentscouncil
  end

  def subscribe
  end

  def schoolcouncil
  end

  def legalterms
  end

  def codeinput
  end

  def codecheck
    if list_available_classrooms_code.include?(code_params[:signin_code])
      @classroom = Classroom.where(signing_code: code_params[:signin_code])
      redirect_to new_user_registration_path(@classroom)
    else
      flash[:alert] = "Votre code n'est pas valide !"
      render 'codeinput'
    end
  end

  def subscribe_form
    send_file(
    "#{Rails.root}/public/formulaire-adhesion20172018.pdf",
    filename: "formulaire-adhesion20172018.pdf",
    type: "application/pdf"
    )
  end

  private

  def code_params
    params.require(:code).permit(:signin_code)
  end

  def list_available_classrooms_code
    Classroom.pluck(:signin_code)
  end

end
