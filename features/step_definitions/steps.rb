# General Functions:

When(/^I swipe "([^"]*)"$/) do |theWay|
  size = $driver.window_size
  if theWay == "up"
    Appium::TouchAction.new.press(x: size.width/2, y: size.height-65).move_to(x: 0, y:-(size.height-65)).release.perform
  elsif theWay == "down"
    Appium::TouchAction.new.press(x: size.width/2, y: size.height/5).move_to(x: 0, y: size.height/1.5).release.perform
  elsif theWay == "right to left"
    Appium::TouchAction.new.press(x: size.width-1, y: size.height/2).move_to(x: -(size.width-1), y: 0).release.perform
  elsif theWay == "left to right"
    Appium::TouchAction.new.press(x: 0, y: size.height/2).move_to(x: size.width-1, y: 0).release.perform
  else
    puts "direction not found"
    fail
  end
end

#When(/^I swipe right to left$/) do
#  size = $driver.window_size
#  Appium::TouchAction.new.press(x: size.width-1, y: size.height/2).move_to(x: -(size.width-1), y: 0).release.perform
#end
#When(/^I swipe left to right$/) do
#  size = $driver.window_size
#  Appium::TouchAction.new.press(x: 0, y: size.height/2).move_to(x: size.width-1, y: 0).release.perform
#end
#When(/^I swipe up$/) do
#  @size = $driver.window_size
#  Appium::TouchAction.new.press(x: @size.width/2, y: @size.height-65).move_to(x: 0, y:-(@size.height-65)).release.perform
#end
#When(/^I swipe down$/) do
#  @size = $driver.window_size
#  Appium::TouchAction.new.press(x: @size.width/2, y: @size.height/5).move_to(x: 0, y: @size.height/1.5).release.perform
#end

When(/^I open phone settings$/) do
  $driver.open_notifications
end

When(/^I press keyboard enter$/) do
  system('adb shell input keyevent 66')
  $driver.press_keycode(66)
end

When(/^I press home$/) do
  system('adb shell input keyevent KEYCODE_HOME')
  sleep(4)
end

When(/^I open recent app "([^"]*)"$/) do |application|
  $driver.press_keycode(187)
  begin
    wait = Selenium::WebDriver::Wait.new :timeout => 15
    wait.until { $driver.find_element(:id, application).displayed? }
    app = $driver.find_element :id, application
    app.click
  rescue
    begin
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:xpath, application).displayed? }
      app = $driver.find_element :xpath, application
      app.click
    rescue
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:accessibility_id, application).displayed? }
      app = $driver.find_element :accessibility_id, application
      app.click
    end
  end
end

When(/^I close and open app$/) do
  $driver.close_app
  sleep(6)
  $driver.launch_app
end

# Select:

When(/^I press on "([^"]*)"$/) do |function|
  begin  
    wait = Selenium::WebDriver::Wait.new :timeout => 15
    wait.until { $driver.find_element(:id, function).displayed? }
    button = $driver.find_element :id, function
    button.click
  rescue
    begin
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:xpath, function).displayed? }
      button = $driver.find_element :xpath, function
      button.click
    rescue
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:accessibility_id, function).displayed? }
      button = $driver.find_element :accessibility_id, function
      button.click
    end
  end
end

When(/^I press on back button$/) do
  $driver.back()
end

#When(/^I press on value "([^"]*)"$/) do |value|
#  pending
#end
#When(/^I press on xpath "([^"]*)"$/) do |value|
#  wait = Selenium::WebDriver::Wait.new :timeout => 15
#  wait.until { $driver.find_element(:xpath, value).displayed? }
#  button = $driver.find_element :xpath, value
#  button.click
#end
#When(/^I press on access_id "([^"]*)"$/) do |value|
#  wait = Selenium::WebDriver::Wait.new :timeout => 15
#  wait.until { $driver.find_element(:accessibility_id, value).displayed? }
#  button = $driver.find_element :accessibility_id, value
#  button.click
#end

# Find:

Then(/^I don't see "([^"]*)"$/) do |function|
  begin
    icon = $driver.find_element(:id,function).displayed?
  rescue
    icon = false
  end
  if icon == true
    fail
  end
end

Then(/^I see "([^"]*)"$/) do |function|
  begin
    wait = Selenium::WebDriver::Wait.new :timeout => 15
    wait.until { $driver.find_element(:id, function).displayed? }
  rescue
    begin
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:xpath, function).displayed? }
    rescue
      wait = Selenium::WebDriver::Wait.new :timeout => 15
      wait.until { $driver.find_element(:accessibility_id, function).displayed? }
    end
  end
end

#Then(/^I see id "([^"]*)"$/) do |function|
#  wait = Selenium::WebDriver::Wait.new :timeout => 15
#  wait.until { $driver.find_element(:id, function).displayed? }
#end
#Then(/^I see access_id "([^"]*)"$/) do |value|
#  wait = Selenium::WebDriver::Wait.new :timeout => 15
#  wait.until { $driver.find_element(:accessibility_id, value).displayed? }
#end
#Then(/^I see value "([^"]*)"$/) do |value|
#  pending
#end
#When(/^I see xpath "([^"]*)"$/) do |value|
#  wait = Selenium::WebDriver::Wait.new :timeout => 15
#  wait.until { $driver.find_element(:xpath, value).displayed? }
#end

# Typing:

When(/^I send "([^"]*)" to "([^"]*)"$/) do |text,field|
  begin
    # if field is found through ID
    icon = $driver.find_element(:id,field).displayed?
  rescue
    icon = false
  end
  if icon == true
    element = $driver.find_element :id, field
    element.click
    element.send_keys(text)
  else
    begin
      # if field is found through xpath
      icon = $driver.find_element(:xpath,field).displayed?
    rescue
      icon = false
    end
    if icon == true
      element = $driver.find_element :xpath, field
      element.click
      element.send_keys(text)
    else
      begin
        # if field is found through accessibility_id
        icon = $driver.find_element(:accessibility_id,field).displayed?
      rescue
        icon = false
      end
      if icon == true
        element = $driver.find_element :accessibility_id, field
        element.click
        element.send_keys(text)
      else
        fail
      end
    end
  end
end

