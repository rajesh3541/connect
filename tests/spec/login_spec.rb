require_relative "../default_context.rb"
require "selenium-webdriver"

describe "login test " do
    include_context "default"
    
    before(:all) do
        #add pre-requisites
    end

    # it "verifies the navigation to the home page " do
    #     open_dashboard
    #     #take_screenshot "Login"
    #     expect(@driver.find_element(:xpath => "//h1[starts-with(@class, 'top_section__title')]").text).to include('Welcome to Accion Connect')
    # end

    # it "verifies first time user login through google account " do
    #     open_dashboard
    #     @driver.find_element(:id => "google-login-button").click
    #     email_tb = @driver.find_element(:xpath => "//input[@type='email']")
    #     if email_tb
    #         email_tb.send_keys "#{Config["test_user"]}"
    #         @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
    #         @driver.find_element(:xpath => "//input[@type= 'password']").send_keys "#{Config["test_pwd"]}"
    #         @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
    #         expect(@driver.find_element(:xpath => "//div[@class='alert alert-warning']//span[2]").text).to include('You need to verify your email address to activate your account.')
    #     end
    # end

    it "verify existing user login through google account " do
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
        # email_tb = @driver.find_element(:xpath => "//input[@type='email']")
        # if email_tb
        #     email_tb.send_keys "#{Config["user_name"]}"
        #     #email_tb.send_keys:return
        #     #sleep 5
        #     @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
        #     sleep 2
        #     @driver.find_element(:xpath => "//input[@type= 'password']").send_keys "#{Config["password"]}"
        #     #@driver.find_element(:xpath => "//input[@type= 'password']").send_keys:return
        #     #sleep 5
        #     @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
        #     sleep 10
        #     expect(@driver.find_element(:xpath => "//button[@id='user-profile']")).to be_truthy
        #     #@driver.find_element(:xpath => "//button[@id='user-profile']").click
        #     #@driver.find_element(:xpath => "//div[@id='profile_container']//a[2]").click
        #     sleep 10
        # end
    end
end