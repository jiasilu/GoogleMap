require "spec_helper"

describe UserMailer do
  describe "confirm" do
    before(:each) do
      @valid_attributes = {
        :username => 'silujia007',
        :email => 'justin@goodinc.com',
        :password => 'password',
        :password_confirmation => 'password'
      }
      @user = User.new(@valid_attributes)
    end
    
    let(:mail) { UserMailer.confirm(@user) }

    it "renders the headers" do
      mail.subject.should eq("Activation Email")
      mail.to.should eq(["justin@goodinc.com"])
      mail.from.should eq(["jiasilu1987@gmail.com"])
    end
  end
end
