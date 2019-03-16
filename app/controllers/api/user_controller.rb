class Api::UserController < ApplicationController

  def show
    @user = User.find(params[:id])
    if !@user.locations.any? && !@user.performers.any?
      render json: {status: "error", code: 3000, message: "Es wurde keine dazugehörige Location oder Performer gefunden"}
    end
  end

end