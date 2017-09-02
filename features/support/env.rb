require 'rubygems'
require 'appium_lib'

desired_caps = {
  caps: {
    platformName: 'Android',
    deviceName: 'Samsung SM-N900W8 (Android 4.4.2, API 19)',
    appPackage: 'com.dubdub.dubcandy',
    appActivity: 'com.dubrise.dubcash.splash.view.SplashActivity',
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
