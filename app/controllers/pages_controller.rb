class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legalterms]

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

  def subscribe_form
    send_file(
    "#{Rails.root}/public/formulaire-adhesion20172018.pdf",
    filename: "formulaire-adhesion20172018.pdf",
    type: "application/pdf"
    )
  end

end
