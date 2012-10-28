require "spec_helper"

describe ApprovalsMailer do
  describe "new_approval" do
    let(:mail) { ApprovalsMailer.new_approval }

    it "renders the headers" do
      mail.subject.should eq("New approval")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
