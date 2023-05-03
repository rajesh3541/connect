module Helpers
    def get_dropdown(*args)
      Selenium::WebDriver::Support::Select.new(@driver.find_element *args)
    end

    def take_screenshot(file_name)  
      @driver.save_screenshot "../screenshots/#{Time.now.strftime("failshot__%d_%m_%Y__%H_%M_%S")}.png"
    end

    def open_dashboard
      if element_present? :xpath => "//button[@id='user-profile']"
        logged_in = "true"
      end
      sleep 2
      if logged_in != "true"
        @driver.get "https://www.google.com/"
        @driver.find_element(:xpath => "//span[contains(text(),'Sign in')]").click
        @driver.find_element(:xpath => "//input[@type='email']").send_keys "#{Config["user_name"]}"
        @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
        sleep 5
        @driver.find_element(:xpath => "//input[@type= 'password']").send_keys "#{Config["password"]}"
        sleep 5
        @driver.find_element(:xpath => "//span[contains(text(), 'Next')]").click
        sleep 2
        @driver.get "#{Config["host"]}"
        sleep 2
        @driver.find_element(:id => "google-login-button").click
        @driver.find_element(:xpath => "//div[@data-email='#{Config["user_name"]}']").click
        sleep 5
        expect(@driver.find_element(:xpath => "//button[@id='user-profile']")).to be_truthy
      end
    end

    def update_test_report
      #system "cd ./reports/"
      system "ruby ./tests/utils/rakefile"
      test_report = File.read('./tests/report.html')
      report_parse = Nokogiri::HTML(test_report)
      test_result = report_parse.css("script").last.to_s
      if (test_result.include? ', 0 failures') == false # if false, there were failures
        open('../reports/diff.diff', 'w') { |f|
          f.puts test_result
          f.puts "Executed on #{$config['host']}"
        }
      end  
      #system("scp ./tests/report.html ./reports/test-report.html")
    end
    
    def element_present? *args
      @driver.manage.timeouts.implicit_wait = 0
      @driver.find_element *args
      @driver.manage.timeouts.implicit_wait = @default_implicit_wait
      true
    rescue Selenium::WebDriver::Error::NoSuchElementError
      @driver.manage.timeouts.implicit_wait = @default_implicit_wait
      false
    end
  
    def frame_switch
      begin
        if element_present? :tag_name => "iframe"
          frame_id = @driver.find_element(:tag_name => "iframe").attribute("id")
          @driver.switch_to.frame frame_id
        end
        true
      rescue Selenium::WebDriver::Error::NoSuchFrameError
        return false
      end
    end
  
    def alert_present?()
      @driver.switch_to.alert
      true
    rescue Selenium::WebDriver::Error::NoAlertPresentError
      false
    end
    
    def clear_alert_if_present
      begin
        @driver.switch_to.alert.accept
        true
      rescue Selenium::WebDriver::Error::NoSuchAlertError
        return false
      end
    end
    
    def dismiss_alert_if_present
      begin
        @driver.switch_to.alert.dismiss
        true
      rescue Selenium::WebDriver::Error::NoAlertPresentError, Selenium::WebDriver::Error::NoSuchAlertError
        return false
      end
    end
  
    def frame_switch
      begin
        if element_present? :tag_name => "iframe"
          frame_id = @driver.find_element(:tag_name => "iframe").attribute("id")
          @driver.switch_to.frame frame_id
        end
        true
      rescue Selenium::WebDriver::Error::NoSuchFrameError
        return false
      end
    end
  
    def close_alert_and_get_its_text(how, what)
      alert = @driver.switch_to().alert()
      alert_text = alert.text
      if (@accept_next_alert) then
        alert.accept()
      else
        alert.dismiss()
      end
      alert_text
    ensure
      @accept_next_alert = true
    end
   
    
    def submit_form(value)
      @driver.find_element(:xpath, "(//input[@value='#{value}'])").click
    end
  
    
    def wait_for(seconds)
      Selenium::WebDriver::Wait.new(timeout: seconds).until { 
        #@driver.save_screenshot 'wait_for.png'
        yield
      }
    end
end
