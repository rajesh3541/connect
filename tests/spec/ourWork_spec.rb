require_relative "../default_context.rb"

describe "On the Locations Page " do
    include_context "default"

    it "verifies the navigation to locations page " do
        open_dashboard
        @driver.find_element(:xpath => "(//*[@id='hamburger-menu'])[1]").click
        @driver.find_element(:xpath => "//*[@id='our-work']").click
        sleep 2
        @driver.navigate.refresh
        expect(@driver.find_element(:xpath => "//h1[contains(text(),'Our Work')]")).to be_truthy
    end

    it "verifies type filter functionality " do
        sleep 2
        type = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]")
        type.send_keys "Case Studies"
        type.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :enter
        sleep 5
        expect(@driver.find_element(:xpath => "//div[@class='content_card'][2]//h1").text).to include("AFS Vision - Credit Risk Navigator - Business Intelligence for Global Banks")
        sleep 5
        @driver.find_element(:xpath => "/html/body/div/main/div/div/div[3]/div").click
        sleep 2
    end

    it "verifies CoE filter functionality " do
        sleep 2
        coe = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]")
        coe.send_keys "Automation"
        coe.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :enter
        sleep 5
        expect(@driver.find_element(:xpath => "//div[@class='content_card'][2]//h1").text).to include("Demo | Playwright Automation Testing Tool")
        sleep 2
        @driver.find_element(:xpath => "/html/body/div/main/div/div/div[3]/div").click
        sleep 2
    end

    it "verifies Author filter functionality " do
        sleep 2
        author = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]")
        author.send_keys "Breeze QA"
        author.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :enter
        sleep 5
        auth = @driver.find_elements(:xpath => "//div[@class='support_text']//a")
        auth.each do |au|
            expect(au.text).to include("Breeze QA")
        end
        sleep 2
        @driver.find_element(:xpath => "/html/body/div/main/div/div/div[3]/div").click
        sleep 2
    end
end