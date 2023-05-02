require_relative "../default_context.rb"
require "selenium-webdriver"

describe "login test " do
    include_context "default"
    
    before(:all) do
        #add pre-requisites
    end

    it "verify existing user login through google account " do
        begin
            open_dashboard
            sleep 2
            @driver.find_element(:id => "google-login-button").click
            @driver.find_element(:xpath => "//div[@data-email='#{Config["user_name"]}']").click
            sleep 10
            expect(@driver.find_element(:xpath => "//button[@id='user-profile']")).to be_truthy
            sleep 2
            @driver.find_element(:xpath => "//button[@id='user-profile']").click
            @driver.find_element(:xpath => "//div[@id='profile_container']//a[2]").click
            sleep 20
        rescue
            take_screenshot
        end
    end
end