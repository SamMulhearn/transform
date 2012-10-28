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
    #user_ids = Role.joins(:users).where(:id => @rfc.role_ids).pluck(:user_id)
    emails = User.joins(:roles => {:rfcs => :roles}).where('rfcs.id' => @rfc.id).pluck(:email).uniq
    # @rfcs.roles.each do |r|
    #   emailstosendto.push(r.users.select(&:email)
    #   sample.push(3, 4, 5)
    mail to: emails, subject: "You have new RFC's to approve."
  end
end
