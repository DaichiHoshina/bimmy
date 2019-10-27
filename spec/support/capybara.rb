# frozen_string_literal: true

require 'capybara/rspec'
require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path = '/usr/bin/google-chrome'

Capybara.register_driver :headless_chrome do |app|
  opts = {
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chrome_options: { args: %w[headless disable-gpu window-size=1680,1050 start-maximized,--no-sandbox'] }
    )
  }
  Capybara::Selenium::Driver.new(app, opts)
end

Capybara.javascript_driver = :headless_chrome
