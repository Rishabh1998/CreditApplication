class CreateLoanApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_applications do |t|
      t.string :email
      t.string :pan_card
      t.string :aadhar_number
      t.string :account_number
      t.string :ifsc
      t.decimal :inflow_amount, :precision => 15, :scale => 2
      t.decimal :outflow_amount, :precision => 15, :scale => 2
      t.decimal :cred_limit, :precision => 15, :scale => 2

      t.timestamps
    end
  end
end
