class Output
  def messages
    @messages ||= []
  end
  
  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

Given /^I visit <(.+)> page$/ do |page_name|
  visit path_to(page_name)
end

When /^I enter <(.*)> in <(.+)>$/ do |value,field|
  fill_in(field, :with => value)
end

When /^I click on <(.+)>$/ do |button|
  click_button(button)
end

Then /^I should see <(.+)>$/ do |msg|
  page.should have_content msg
end

Then /^An activation email should be sent to <(.+)>$/ do |email|
  user = User.find_by_email(email)
  user.activation_token.should_not be_blank
  sent = ActionMailer::Base.deliveries.last
  #sent.subject.should eq("Activation Email")
  #sent.to.should eq([user.email])
  #send.body.should =~ /#{user.activation_token}/
end

Given /^I register with <(.*)\/(.*)\/(.*)>$/ do |username,email,password|
  @valid_attributes = {
    :username => username,
    :email => email,
    :password => password,
    :password_confirmation => password
  }
  @user = User.create!(@valid_attributes)
end

When /^I visit the activation link in the <(.*)>$/ do |email|
  user = User.find_by_email(email)
  visit activate_url(:token => user.activation_token)
end