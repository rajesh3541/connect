require_relative "../default_context.rb"

describe "On the Accioners page " do
    include_context "default"

    it "verifies the navigation to accioners page " do
        open_dashboard
        @driver.find_element(:xpath => "(//*[@id='hamburger-menu'])[1]").click
        @driver.find_element(:xpath => "//*[@id='drawer_container']/div/div/ul/div[1]/a/h5").click
        sleep 2
        expect(@driver.find_element(:xpath => "//h1[contains(text(),'Accionites')]")).to be_truthy
    end

    it "verifies location filter functionality " do
        sleep 2
        location = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]")
        location.send_keys "Pune"
        location.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :enter
        sleep 5
        loc_list = @driver.find_elements(:xpath => "/html/body/div/main/div/div[2]/div/div/div/div[2]/div[3]/p/span")
        loc_list.each do |loc|
            expect(loc.text.downcase).to match("pune")
        end
        @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
        sleep 2
    end

    it "verifies role filter functionality " do
        sleep 2
        role = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]")
        role.send_keys "Team Work"
        role.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :enter
        sleep 5
        rol_list = @driver.find_elements(:xpath => "/html/body/div/main/div/div[2]/div/div/div/div[2]/div[2]/p/span")
        rol_list.each do |rol|
            expect(rol.text.downcase).to match("team work")
        end
        @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
        sleep 2
    end

    it "verifies skill filter functionality " do
        sleep 2
        skill = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]")
        skill.send_keys "Nexial"
        skill.send_keys:return
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :down
        @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :enter
        sleep 5
        skl_list = @driver.find_elements(:xpath => "/html/body/div/main/div/div[2]/div/div/div/div[2]/div[5]/p/span")
        skl_list.each do |skl|
            expect(skl.text.downcase).to match("nexial")
        end
        @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
        sleep 2
    end
end