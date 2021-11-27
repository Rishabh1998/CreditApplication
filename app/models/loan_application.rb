class LoanApplication < ApplicationRecord
    include ApiHelper
    validates :email, :pan_card, :aadhar_number, :account_number, :ifsc, :inflow_amount, :outflow_amount, presence: true

    enum status: {:pending => 1, :approved => 2, :rejected => 3}

    before_save :calculate_cred_limit
    before_save :get_credibility_score
    before_save :check_if_system_recommended

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

    def get_credibility_score
        response = ApiReader.new.get_request("https://api.fullcontact.com/v2/person.json?email=#{self.email}")
        response = JSON.parse(response)
        self.credibility_score = 0
        if response["status"] == 200
            response["socialProfiles"].each do |profile|
                case profile["type"]
                    when "facebook"
                        self.credibility_score += 1
                    when "twitter"
                        self.credibility_score += 1
                    when "linkedin"
                        self.credibility_score += 1
                end
            end
        end
        approved_loans = LoanApplication.where(:email => self.email, status: 'approved').count
        self.credibility_score += 1 if approved_loans > 0
    end

    def check_if_system_recommended
        if self.credibility_score >= 2
            self.system_recommendation = true
        end
    end
        
end
