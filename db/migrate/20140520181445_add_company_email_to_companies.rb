class AddCompanyEmailToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :company_email, :string
  end
end
