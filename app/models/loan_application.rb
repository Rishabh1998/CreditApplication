class LoanApplication < ApplicationRecord
    validates :email, :pan_card, :aadhar_number, :account_number, :ifsc, :inflow_amount, :outflow_amount, presence: true
    validates :email, uniqueness: true

    enum status: {:pending => 1, :approved => 2, :rejected => 3}

    before_save :calculate_cred_limit

    def calculate_cred_limit
        maximum_possible_emi = ((self.inflow_amount/2) - self.outflow_amount).round(2)
        case maximum_possible_emi
            when 0..5000
                terms_in_month = 6
            when 5000..10000
                terms_in_month = 12
            when 10000..20000
                terms_in_month = 18
            when 20000..30000
                terms_in_month = 24
        end

        self.cred_limit = maximum_possible_emi * terms_in_month
    end
end
