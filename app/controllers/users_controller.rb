class UsersController < ApplicationController
  # Require user to be logged in
  before_filter :authenticate_user!

  def show
    @current_user = User.find(current_user.id)
    @current_decks = @current_user.decks
  end
end
