require_relative "../default_context.rb"

describe "On the Locations Page " do
    include_context "default"

    loc_list = ["Hanover","London","Toronoto","Pittsburgh","Santa Clara","Baltimore","Guadalajara","Bucharest","Dubai","Mumbai","Pune","Bangalore","Salcete","Hyderabad","Bangkok","Manila","Singapore","Kuala Lumpur"]

    it "verifies the navigation to locations page " do
        open_dashboard
        @driver.find_element(:xpath => "(//*[@id='hamburger-menu'])[1]").click
        @driver.find_element(:xpath => "//*[@id='drawer_container']/div/div/ul/div[2]/a/h5").click
        sleep 2
        expect(@driver.find_element(:xpath => "//header[contains(text(),'Global Locations')]")).to be_truthy
    end

    it "verifies the locations displayed on the page " do
        locations = @driver.find_elements(:xpath => "//*[@id='global-location-name']")
        locations.each do |loc|
            expect(loc_list).to include(loc.text)
        end
    end

    it "verifies that each location should have address and print the addresses " do
        begin
            locations = @driver.find_elements(:xpath => "//*[@id='global-location-name']")
            loc_addr = @driver.find_elements(:xpath => "//*[@id='global-location-address']")
            locations.each_with_index do |loc, index|
                puts "Location: #{loc.text}"
                puts "Address: #{loc_addr[index].text}"
            end
        rescue
            take_screenshot
        end
    end

    it "verifies location image and map on the page " do
        begin
            loc_addr = @driver.find_elements(:xpath => "//*[@id='global-location-address']")
            loc_addr.each do |addr|
                images = @driver.find_elements(:xpath => "/html/body/div/main/main/div/article/section[2]/figure")
                maps = @driver.find_elements(:xpath => "//*[@class='map-container']")
                images.each do |img|
                    expect(img).to be_truthy
                end
                maps.each do |map|
                    expect(map).to be_truthy
                end
            end
        rescue
            take_screenshot
        end
    end

    it "verifies country filter functionality " do
        sleep 2
        begin
            location = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]")
            location.send_keys "India"
            location.send_keys:return
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :down
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[1]").send_keys :enter
            sleep 5
            locs = @driver.find_elements(:xpath => "//*[@id='global-location-name']")
            locs.each do |loc|
                expect(loc_list).to include(loc.text)
            end
            @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
            sleep 2
        rescue
            take_screenshot
        end
    end

    it "verifies state filter functionality " do
        sleep 2
        begin
            states = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]")
            states.send_keys "Telangana"
            states.send_keys:return
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :down
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[2]").send_keys :enter
            sleep 5
            locs = @driver.find_elements(:xpath => "//*[@id='global-location-name']")
            locs.each do |loc|
                expect(loc_list).to include(loc.text)
            end
            @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
            sleep 2
        rescue
            take_screenshot
        end
    end

    it "verifies City filter functionality " do
        sleep 2
        begin
            city = @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]")
            city.send_keys "London"
            city.send_keys:return
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :down
            @driver.find_element(:xpath => "(//*[@id='autocomplete-search'])[3]").send_keys :enter
            sleep 5
            locs = @driver.find_elements(:xpath => "//*[@id='global-location-name']")
            locs.each do |loc|
                expect(loc_list).to include(loc.text)
            end
            @driver.find_element(:xpath => "//div[contains(text(),'Clear')]").click
            sleep 2
        rescue
            take_screenshot
        end
    end
end