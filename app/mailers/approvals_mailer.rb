class ApprovalsMailer < ActionMailer::Base
  default from: "transform@tribalgroup.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.approvals_mailer.new_approval.subject
  #
  def new_approval(rfc)
    @greeting = "Hi"
    @rfc = rfc

    mail to: "sam.mulhearn@gmail.com", subject: "You have new RFC's to approve."
  end
end
