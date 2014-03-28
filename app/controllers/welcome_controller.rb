class WelcomeController < ApplicationController

  def index
    flash[:success] = t(:something_is_successful)
    flash[:error] = t(:uh_oh_something_is_wrong)
  end
end