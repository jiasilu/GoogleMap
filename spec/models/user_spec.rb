require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :username => '404',
      :email => '404@usc.edu',
      :password => 'password',
      :password_confirmation => 'password'
    }
    @user = User.new(@valid_attributes)
  end
  
  it "should be valid" do
    @user.should be_valid
  end
  
  it "should require a username" do
    @user.username = ''
    @user.should_not be_valid
    @user.should have(1).errors_on(:username)
  end
  
  it "should not be valid without a email" do
    @user.email = ''
    @user.should_not be_valid
  end
  
  it "should be valid if email past the correct match" do
    @user.email.should match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
  end

  it "should have a unique username and password" do
    @first_user = User.create!(@valid_attributes)
    @second_user = User.new(@valid_attributes)
    @second_user.should_not be_valid
    @second_user.should have(1).errors_on(:username)
    @second_user.should have(1).errors_on(:email)
  end
  
  it "should not be valid without a password" do
    @user.password = ''
    @user.should_not be_valid
  end
  
  it "should be valid if password has a minimum of 4 characters" do
    @user.password.should have_at_least(4).characters
  end
  
  it "should be valid if password has not more than 40 characters" do
    @user.password.should have_at_most(40).characters
  end
  
  it "should be valid if password and password confirmation match" do
    @user.password_confirmation.should == @user.password
  end
  
  it "should encrypt the password before saving to the database" do
    @user.save
    @user.password_salt.should_not be_nil
    @user.encrypted_password.should_not be_nil
  end
    
end
