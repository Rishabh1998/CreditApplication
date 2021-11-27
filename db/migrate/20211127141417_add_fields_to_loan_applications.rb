class AddFieldsToLoanApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :loan_applications, :credibility_score, :integer
    add_column :loan_applications, :status, :integer, :default => 1
    add_column :loan_applications, :system_recommendation, :boolean, :default => false
  end
end
