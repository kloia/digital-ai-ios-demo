module PageHelper

  def self.find(locator, wait: BaseConfig.wait_time)
    wait_true(timeout: wait, message: "NoSuchElementError: #{locator}") do
      find_element(locator)
    end
  end

  def self.click_element(locator, wait: BaseConfig.wait_time)
    find(locator, wait: wait).click
  end

  # @return Boolean.
  def self.is_element_enabled(locator, wait: BaseConfig.wait_time)
    @is_element = true
    begin
      wait_true(timeout: wait, message: "NoSuchElementError: #{locator}") do
        find_element(locator).enabled?
      end
    rescue StandardError
      @is_element = false
    end
    @is_element
  end

  def self.send_keys_with_keycodes(input)
    key_codes = (("a".."z").to_a.zip((29..54).to_a).to_h).merge(("0".."9").to_a.zip((7..16).to_a).to_h)
    input = input.to_s
    (0...input.length).each { |a|
      if input[a] == input[a].upcase
        press_keycode(115)
        press_keycode(key_codes[input[a].downcase])
        press_keycode(115)
      else
        press_keycode(key_codes[input[a]])
      end
    }
    hide_keyboard
  end

  def swipe_until(type, locator, swipe_count = 5)
    count = swipe_count
    visible = false
    while count.positive?
      begin
        visible = find(locator, wait: 2).attribute('displayed').eql?('true') ? true : raise
        count = 0
      rescue StandardError
        case type
        when "down"
          swipe_down
        when "up"
          swipe_up
        when "right"
          swipe_right
        when "left"
          swipe_right
        end
        count -= 1
      end
    end
    raise "Element not found locator: #{locator} " if count.zero? && visible == false
  end

  def self.swipe_down
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.swipe(start_x: (window_width * 0.5).to_int,
                                  start_y: (window_height * 0.8).to_int,
                                  offset_x: (window_width * 0.5).to_int,
                                  offset_y: (window_height * 0.2).to_int,
                                  duration: 5000).release.perform
  end

  def self.swipe_up
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.swipe(start_x: (window_width * 0.5).to_int,
                                  start_y: (window_height * 0.1).to_int,
                                  offset_x: (window_width * 0.5).to_int,
                                  offset_y: (window_height * 0.8).to_int,
                                  duration: 5000).release.perform
  end

  def self.swipe_right
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.swipe(start_x: (window_width * 0.7).to_int,
                                  start_y: (window_height * 0.15).to_int,
                                  offset_x: (window_width * 0.2).to_int,
                                  offset_y: (window_height * 0.15).to_int,
                                  duration: 5000).perform
  end

  def self.swipe_left
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.swipe(start_x: (window_width * 0.7).to_int,
                                  start_y: (window_height * 0.15).to_int,
                                  offset_x: (window_width * 0.2).to_int,
                                  offset_y: (window_height * 0.15),
                                  duration: 5000).perform
  end

  # @abstract Scrolls until element is found.
  # @!attribute type can be "down" or "up". Default is "down".
  def self.scroll_until_element(locator, type, scroll_count = 10)
    count = scroll_count
    visible = false
    while count.positive?
      begin
        visible = find(locator, wait: 2).attribute('displayed').eql?('true') ? true : raise
        count = 0
      rescue StandardError
        scroll_down if type == "down"
        scroll_up if type == "up"
        count -= 1
      end
    end
    raise "Element not found locator: #{locator} " if count.zero? && visible == false
  end

  # @abstract Scrolls down given amount of argument times.
  def self.scroll_down_multiple_times(scroll_times)
    count = scroll_times
    while count.positive?
      scroll_down
      count -= 1
    end
  end

  def self.scroll_down
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.press({ x: (window_width * 0.05).to_int, y: (window_height * 0.8).to_int })
                       .wait(5000)
                       .move_to({ x: (window_width * 0.05).to_int, y: (window_height * 0.2).to_int })
                       .release
                       .perform
  end

  def self.scroll_up
    window_width = window_size.width
    window_height = window_size.height
    Appium::TouchAction.new.press({ x: (window_width * 0.05).to_int, y: (window_height * 0.2).to_int })
                       .wait(5000)
                       .move_to({ x: (window_width * 0.05).to_int, y: (window_height * 0.8).to_int })
                       .release
                       .perform
  end

  # @abstract Finds the amount of an element existed on the page.
  # @return Integer
  def self.element_size(locator)
    find_elements(locator).size
  end

  # @abstract Checks if an element exists or not on the page.
  # @return Boolean.
  def self.is_element(locator, wait: BaseConfig.wait_time)
    @is_element = true
    begin
      wait_true(timeout: wait, message: "NoSuchElementError: #{locator}") do
        element_size(locator) > 0
      end
    rescue StandardError
      @is_element = false
    end
    @is_element
  end

  def self.simulate_capture(file_url)
    driver.execute_script("seetest:client.simulateCapture('#{file_url}')")
  end

end

World(PageHelper)