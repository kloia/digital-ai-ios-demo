begin
  class SimulateCapture
    def initialize
      @btn_advance_options = { xpath: '//XCUIElementTypeStaticText[@name="Advanced Actions"]' }
      @btn_scan_check = { xpath: '//XCUIElementTypeStaticText[@name="Scan Check"]' }
      @btn_scan = { xpath: '//XCUIElementTypeStaticText[@name="Scan check"]' }
      @btn_done = { xpath: '//*[@label="Done"]' }
    end

    def click_advance_options
      PageHelper.click_element(@btn_advance_options)
    end

    def click_scan_check
      PageHelper.click_element(@btn_scan_check)
    end

    def click_scan
      PageHelper.click_element(@btn_scan)
    end

    def click_file_scan
      PageHelper.simulate_capture('https://www.pixsy.com/wp-content/uploads/2015/06/copy-image-address.jpg')
      sleep 5
      PageHelper.click_element(@btn_done)
    end
  end
end
