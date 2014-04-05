class EmailsController < ApplicationController
  expose(:email) { Email.find params[:id] }
  def show; end
end