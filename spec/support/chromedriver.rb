# ChromeDriver for JavaScript enabled feature/system specs
#
# Example usage:
# `$ bin/rspec` # Chrome in Headless Mode (Default)
# `$ SHOW_BROWSER=true bin/rspec` # Chrome
# `$ SHOW_BROWSER=true DEVTOOLS=true bin/rspec` # Chrome with Devtools

require 'selenium/webdriver'

Capybara.register_driver :chrome do |app|
  chrome_driver(app, chrome_options: %w[window-size=1440,1080])
end

Capybara.register_driver :headless_chrome do |app|
  chrome_driver(app, chrome_options: %w[headless disable-gpu window-size=1440,1080])
end

Capybara.register_driver :chrome_with_devtools do |app|
  chrome_driver(app, chrome_options: %w[window-size=2560,1440 auto-open-devtools-for-tabs])
end

def chrome_driver(app, chrome_options:)
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: chrome_options }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 url: ENV.fetch('SELENIUM_REMOTE_URL') { 'http://selenium:4444/wd/hub' },
                                 desired_capabilities: capabilities
end

def select_javascript_driver
  if ENV['SHOW_BROWSER'] && ENV['DEVTOOLS']
    :chrome_with_devtools
  elsif ENV['SHOW_BROWSER'] 
    # ./run cmd bash -c ' SHOW_BROWSER=1  rspec spec/system'  
    :chrome
  else
    :headless_chrome
  end
end

Capybara.javascript_driver = select_javascript_driver
