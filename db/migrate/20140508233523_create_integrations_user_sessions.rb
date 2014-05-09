class CreateIntegrationsUserSessions < ActiveRecord::Migration
  def change
    create_table :integrations_user_sessions do |t|
      t.references :user, index: true
    end
  end
end
