# == Schema Information
#
# Table name: integrations_user_sessions
#
#  id      :integer          not null, primary key
#  user_id :integer
#

class Integrations::UserSession < ActiveRecord::Base
  self.table_name = 'integrations_user_sessions'
  belongs_to :user,
    class_name: 'FoxYam::User'
end
