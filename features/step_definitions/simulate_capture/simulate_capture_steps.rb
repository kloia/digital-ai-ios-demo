simulate_capture = SimulateCapture.new

And(/^click advance options$/) do
  simulate_capture.click_advance_options
end

And(/^click scan$/) do
  simulate_capture.click_scan_check
  simulate_capture.click_scan
end

And(/^simulate capture$/) do
  simulate_capture.click_file_scan
end