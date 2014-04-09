class UsersController < ApplicationController
  expose(:user) { User.find params[:id] }
  def show; end
end