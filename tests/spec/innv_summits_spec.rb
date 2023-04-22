require_relative "../default_context.rb"

describe "On the Locations Page " do
    include_context "default"

    page_sections = ["Innovation Summit","Explore Innovation Summit","Speaker","Gallery","Summit Tech Talk","8","Years","200","Digital Technologies","50","Code Walkthroughs","160","Experts","120","Tech Talks","30","Live Demos","Dubai 2023","Goa 2022","Goa 2019","Goa 2018"]

    it "verifies the navigation to innovation summits page " do
        open_dashboard
        @driver.find_element(:xpath => "(//*[@id='hamburger-menu'])[1]").click
        @driver.find_element(:xpath => "//*[@id='drawer_container']/div/div/ul/div[4]/div[2]/a[1]/h6").click
        sleep 2
        @driver.navigate.refresh
        expect(@driver.find_element(:xpath => "(//p[contains(text(),'Innovation Summit')])[1]")).to be_truthy
    end

    it "verifies sections available on the page " do
        sleep 2
        sections = @driver.find_elements(:xpath => "//p[starts-with(@class,'MuiTypography-root MuiTypography-body1')]")
        sections.each do |sec|
            expect(page_sections).to include(sec.text)
        end
        sleep 2
    end

    it "verifies Year filter functionality " do
        sleep 2
        coe = @driver.find_element(:xpath => "//*[@id='autocomplete-search']")
        year = "Goa 2022"
        coe.send_keys year
        coe.send_keys:return
        @driver.find_element(:xpath => "//*[@id='autocomplete-search']").send_keys :down
        @driver.find_element(:xpath => "//*[@id='autocomplete-search']").send_keys :enter
        sleep 5
        @driver.navigate.refresh
        sleep 2
        expect(@driver.find_element(:xpath => "(//p[starts-with(@class,'MuiTypography-root MuiTypography-body1')])[2]").text).to include(year)
        sleep 2
        @driver.find_element(:xpath => "/html/body/div/main/div/div/div[3]/div").click
        sleep 2
    end

    it "verifies Author filter functionality " do
        summit_image = @driver.find_elements(:xpath => "//div[starts-with(@class,'MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12')]//img[@alt='summit']")
        summit_year = @driver.find_elements(:xpath => "//div[starts-with(@class,'MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12')]//p")
        summit_image.each_with_index do |si,index|
            expect(si).to be_truthy
            expect(summit_year[index]).to be_truthy
        end
    end

    it "verifies the speakers section " do
        speakers_list = ["Ashutosh Bijoor","Aswani Yadavilli","Dwaip (dc)","Hemesh Thakkar","Kinesh Doshi","Ramesh Narasimhan"]
        speaker_images = @driver.find_elements(:xpath => "//div[starts-with(@class,'MuiGrid-root MuiGrid-item MuiGrid-grid-xs-6 MuiGrid-grid-sm-6 MuiGrid-grid-md-2')]//img")
        speakers = @driver.find_elements(:xpath => "//div[starts-with(@class,'MuiGrid-root MuiGrid-item MuiGrid-grid-xs-6 MuiGrid-grid-sm-6 MuiGrid-grid-md-2')]//h6[1]")
        speaker_images.each_with_index do |si,index|
            expect(si).to be_truthy
            expect(speakers_list).to include(speakers[index].text)
        end
    end

    it "verifies that images are available in the Gallery section " do
        gallery = @driver.find_elements(:xpath => "/html/body/div/main/div/div[9]/div/div/div/img")
        img_count = gallery.size
        expect(img_count).to be >=6
    end

    it "verifies that videos are available in the Summit Tech Talk section " do
        video_gallery = @driver.find_elements(:xpath => "/html/body/div/main/div/div[12]/div/div/div/div/img")
        vid_count = video_gallery.size
        expect(vid_count).to be >=8
    end
end