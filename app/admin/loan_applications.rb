ActiveAdmin.register LoanApplication do

    actions :all, except: [:new, :create]

    member_action :approve, method: :put do
        resource.update(status: "approved")
        redirect_to admin_loan_applications_path, notice: "Loan application was successfully approved."
    end

    member_action :reject, method: :put do
        resource.update(status: "rejected")
        redirect_to admin_loan_applications_path, notice: "Loan application was successfully rejected."
    end

    scope("Approved") { |scope| scope.where(status: 'approved') }
    scope("Rejected") { |scope| scope.where(status: 'rejected') }
    scope("Pending", default: true) { |scope| scope.where(status: 'pending') }

    index do
        column :id, class: "col-md-2"
        column :email, class: "col-md-2"
        column :cred_limit, class: "col-md-2"
        column :system_recommendation, class: "col-md-2"
        actions defaults: false do |loan_application|
            item "Approve", approve_admin_loan_application_path(loan_application), method: :put, class: "member_link" if loan_application.status == "pending"
            item "Reject", reject_admin_loan_application_path(loan_application), method: :put, class: "member_link" if loan_application.status == "pending"
        end
    end
end