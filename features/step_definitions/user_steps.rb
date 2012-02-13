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
  output.messages.should include(msg)
end