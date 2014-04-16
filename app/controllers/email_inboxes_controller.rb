class EmailInboxesController < ApplicationController
  expose(:inbox) { FoxYam::EmailInbox.find params[:id] }
  def show; end
end