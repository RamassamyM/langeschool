# require 'pry-byebug'

class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unseen + current_user.notifications.lastseen
    current_user.has_seen_notifications
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
end
