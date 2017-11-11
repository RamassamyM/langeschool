class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def parentscouncil
  end

  def schoolcouncil
  end
end
