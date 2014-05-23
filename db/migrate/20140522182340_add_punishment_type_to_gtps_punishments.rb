class AddPunishmentTypeToGtpsPunishments < ActiveRecord::Migration
  def change
    add_column :gtps_punishments, :punishment_type, :string
  end
end
