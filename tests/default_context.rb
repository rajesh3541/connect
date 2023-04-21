require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations
require "yaml"
require 'net/ssh'
require 'net/scp'
require 'rest-client'
require_relative '../tests/utils/helpers.rb'
require 'fileutils'
require 'nokogiri'

RSpec.configure do |c|
  c.include Helpers
  c.example_status_persistence_file_path = "testResults.txt"
  c.run_all_when_everything_filtered = true
end

Config = YAML.load_file '../config.yaml'
#ENV['use_ssh'] = Config['use_ssh'].to_s
shared_context "default" do
  before(:all) do
    @host = Config["host"]
    time = Time.new
    ss_folder=time.strftime("%b_%d")
    FileUtils.mkdir_p './screenshots/#{ss_folder}'
    # use firefox
    if Config["browser"] == "Selenium::WebDriver.for :Firefox"
      Selenium::WebDriver::Firefox::Service.driver_path = "../drivers/geckodriver.exe"
      capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
      options = Selenium::WebDriver::Firefox::Options.new
      if Config["headless"] == true
        options.headless!
      end
      @driver = Selenium::WebDriver::Driver.for :firefox, capabilities: capabilities, options: options
    end
    # use chrome
    if Config["browser"] == "Selenium::WebDriver.for :Chrome"
      Selenium::WebDriver::Chrome::Service.driver_path = "../drivers/chromedriver.exe"
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(accept_insecure_certs: true)
      options = Selenium::WebDriver::Chrome::Options.new

      if Config["headless"] == true
        options.add_argument('--headless')
      end
      @driver = Selenium::WebDriver::Driver.for :chrome, options: options
    end

    @content_types = Hash.new
    @default_implicit_wait = 30
  end

  after(:all) do
    update_test_report
    @driver.quit
  end

  before(:each) do
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = @default_implicit_wait
    @verification_errors = []
  end
  
  after(:each) do
    update_test_report
    expect(@verification_errors).to eq([])
  end
end