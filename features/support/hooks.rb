Before do |scenario|
  Loggers.log_info("#{scenario.name} is started")
  driver.start_driver
end

After do |scenario|
  begin
    if scenario.failed?
      Loggers.log_error("FAILED ==> #{scenario.name}\n#{scenario.exception}:#{scenario.exception.message}")
      Loggers.take_screenshot(scenario.name)
      driver.execute_script('seetest:client.setReportStatus("Failed","test is failed","a stacktrace")')
    else
      Loggers.log_info("PASSED ==> #{scenario.name}")
      driver.execute_script('seetest:client.setReportStatus("Passed","test is passed","a stacktrace")')
    end
    $test_id = driver.bridge.capabilities["reportTestId"]
    report_url = DigitalaiApiUtil.get_report_uri($test_id.to_i).to_s
    Loggers.log_info(report_url.to_s)
    Allure.add_link(name: "Report Link", url: report_url)
  rescue StandardError => e
    driver.driver_quit
  end
  driver.driver_quit
end