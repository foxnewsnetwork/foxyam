class EmailInboxesController < ApplicationController
  expose(:inbox) { EmailInbox.find params[:id] }
  def show; end
end