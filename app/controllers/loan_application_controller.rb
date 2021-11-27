class LoanApplicationController < ApplicationController
  
    def new
        @loan_application = LoanApplication.new
    end

    def create
      @loan_application = LoanApplication.new(loan_application_params)
      if @loan_application.save
        render json: @loan_application
      else
        render json: @loan_application.errors, status: :unprocessable_entity
      end
    end

    private

    def loan_application_params
        params.require(:loan_application).permit(:email, :pan_card, :aadhar_number, :account_number, :ifsc, :inflow_amount, :outflow_amount)
    end
end