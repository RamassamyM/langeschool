# require 'pry-byebug'

class NotificationsController < ApplicationController
  def index
    # option: display all notifs or just group notifs (but badge number pb):
    # @notifications = current_user.notifications.unseen + current_user.notifications.lastseen
    @notifications = current_user.notifications.unseen + current_user.notifications.from_lastseen_distinct_messages
    # @notifications = current_user.notifications.from_unseen_distinct_messages + current_user.notifications.from_lastseen_distinct_messages
    current_user.has_seen_notifications
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
end
