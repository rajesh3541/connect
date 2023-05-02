require_relative "../default_context.rb"

describe "Menu spec " do
    include_context "default"

    menu_list = ["Accionites","Global Locations","Our Work","Innovation Summit","Knowledge Center"]
    our_work = ["Case Studies","Product Demos"]
    innv_summit = ["About Summit","Dubai 2023","Goa 2022","Goa 2019","Goa 2018"]
    know_center = ["Presentations","Articles","Podcasts"]
    
    it "verifies if all menu options present " do
        begin
            open_dashboard
            @driver.find_element(:xpath => "(//*[@id='hamburger-menu'])[1]").click
            puts "Below is the list of Main menu options: "
            menu_items = @driver.find_elements(:xpath => "//ul[starts-with(@class,'MuiList-root MuiList-padding')]//h5")
            get_list menu_items, menu_list
        rescue
            take_screenshot
        end
    end

    it "verifies the options available under Our Work menu " do
        begin
            puts "Below are the option available under Our Work menu "
            menu_items = @driver.find_elements(:xpath => "//*[@id='drawer_container']/div/div/ul/div[3]/div[2]/a/h6")
            get_list menu_items, our_work
        rescue
            take_screenshot
        end
    end

    it "verifies the options available under Innovation summit menu " do
        begin
            puts "Below are the option available under Innovation Summit menu "
            menu_items = @driver.find_elements(:xpath => "//*[@id='drawer_container']/div/div/ul/div[4]/div[2]/a/h6")
            get_list menu_items, innv_summit
        rescue
            take_screenshot
        end
    end

    it "verifies the options available under Knowledge Center menu " do
        begin
            puts "Below are the option available under Our Work menu "
            menu_items = @driver.find_elements(:xpath => "//*[@id='drawer_container']/div/div/ul/div[5]/div[2]/a/h6")
            get_list menu_items, know_center
        rescue
            take_screenshot
        end
    end

    def get_list(ele,sec)
        ele.each do |menu|
            puts menu.text
            expect(sec).to include(menu.text)
        end
    end
end