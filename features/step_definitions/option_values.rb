Then /^I should see option values for (.*)$/ do |value_string|
  values = value_string.gsub(" and ", ", ").split(", ")
  within "table.index.sortable" do
    values.each do |value|
       assert page.has_selector? "input[value='#{value}']"
    end
  end
end

Then /^I fill in the option value fields for (.*)$/ do |parent|
  if parent == 'the new option value'
    parent = "tbody#option_values tr:first-child"
  else
    matches = parent.match(/([^"]*)"$/)
    ov = Spree::OptionValue.find_by_presentation(matches[matches.length - 1])
    parent = "tr#spree_option_value_#{ov.id}"
  end
  within parent do
    %w(name presentation).each do |name|
      find("td.#{name} input").set('XXX-Large')
    end
    find("input[type='file']").set(File.expand_path("../../../test/support/images/1.jpg", __FILE__))
  end
end


Then /^I should see image "([^"]*)"$/ do |source|
  within "table.index" do
    assert has_xpath?(".//img[contains(@src, '#{source}')]")
  end
end

When /^I remove option type "([^"]*)"$/ do |value_string|
  ov = Spree::OptionValue.find_by_presentation(value_string)
  within "tr#spree_option_value_#{ov.id}" do
     find(".spree_remove_fields").click
  end
end

#============================================================
# Attempts at sortables...

#When /^I drag option value "([^"]*)" to the top$/ do |value_string|
#  ov = OptionValue.find_by_presentation(value_string)
#  page.driver.browser.drag_and_drop("#option_value_#{ov.id} span.handle", "0,-100")
#end

#When /^I drag option value "([^"]*)" to the top$/ do |value_string|
#  ov = OptionValue.find_by_presentation(value_string)
#  from = find("#option_value_#{ov.id} span.handle")
#  to   = find("table.index tr:first")
#  from.drag_to(to) 
#end
#
#When /^I reload the page$/ do
#  visit current_path
#end
#
#Then /^I should see "([^"]*)" as the first option value$/ do |value_string|
#  ov = OptionValue.find_by_presentation(value_string)
#  #assert_equal 1, ov.position
#  #assert_equal find("table.index tr:first"), find("#option_value_#{ov.id}")
#end

