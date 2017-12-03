class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all
    @conversation = Conversation.new
  end
end
