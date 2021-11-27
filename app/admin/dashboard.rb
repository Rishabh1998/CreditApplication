ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Loan Applications" do
          table do
            tr do
              th "Total"
              th "Approved"
              th "Rejected"
              th "Pending"
            end
            tr do
              loan_applications = LoanApplication.all
              td loan_applications.count
              td loan_applications.where(status: "approved").count
              td loan_applications.where(status: "rejected").count
              td loan_applications.where(status: "pending").count
            end
          end
        end
      end
    end
  end
end
