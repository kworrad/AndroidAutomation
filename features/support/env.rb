require 'rubygems'
require 'appium_lib'

desired_caps = {
  caps: {
    platformName: 'Android',
    deviceName: '.....',
    appPackage: 'com.dubdub.dubcandy',
    appActivity: '.....',
    noReset: 'true',
    platformVersion: '4.4.2',
    exported: 'true'
  }
}

Before do
  $driver = Appium::Driver.new(desired_caps)
  $driver.start_driver
end

After do
  $driver.driver_quit
end
