require_relative "../default_context.rb"

describe "Menu spec " do
    include_context "default"
    
    it "verified if all menu options present " do
        open_dashboard
        @driver.find_elements(:xpath => "//ul[starts-with(@class, 'MuiList-root MuiList-padding')]")
    end
end