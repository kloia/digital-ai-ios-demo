module Loggers

  # Prints log on STDOUT. Also saves it as Allure report. Use it to log Infos.
  # @param log (string): The message to be printed out.
  def self.log_info(log)
    Logger.new(STDOUT).info(log)
    Allure.add_attachment(name: 'Info Log', source: log, type: Allure::ContentType::TXT, test_case: false)
  end

  # Prints log on STDOUT. Also saves it as Allure report. Use it to log Errors.
  # @param log (string): The message to be printed out.
  def self.log_error(log)
    Logger.new(STDOUT).error(log)
    Allure.add_attachment(name: 'Error Log', source: log, type: Allure::ContentType::TXT, test_case: false)
  end

  # Prints log on STDOUT. Also saves it as Allure report. Use it to log Debugs.
  # @param log (string): The message to be printed out.
  def self.log_debug(log)
    Logger.new(STDOUT).debug(log)
    Allure.add_attachment(name: 'Debug Log', source: log, type: Allure::ContentType::TXT, test_case: false)
  end

  #Takes screenshot and attaches the image to Allure report.
  # @param file_name (string): Name of the image file.
  def self.take_screenshot(file_name)
    time = Time.new
    time_day = time.strftime('%Y-%m-%d')
    time_hours = time.strftime('%H-%M-%S')
    file_path = "output/screenshots-#{time_day}"
    FileUtils.mkdir_p(file_path) unless File.directory?(file_path)
    screenshot_name = "#{file_path}/#{file_name.gsub(" ", '_')}-#{time_hours}.png"
    screenshot(screenshot_name)
    Allure.add_attachment(name: 'Screenshot', source: screenshot(screenshot_name.to_s), type: Allure::ContentType::PNG,
                          test_case: true)
  end

  def self.take_video_recording(file_name)
    if BaseConfig.video_recording
      recording_path = create_file_path_for_record(file_name, "videos")
      driver.stop_and_save_recording_screen("#{recording_path[:recording_path]}.mp4")
      aws_s3_path = AwsS3Helper.uploadS3(recording_path[:file_path], "#{recording_path[:file_name]}.mp4")
      Allure.add_link(url:"#{aws_s3_path}", name:'Video Recording')
    else
      IGLoggers.log_info("The video recording was not saved. Environment parameter is turned off for recording.")
    end
  end
end