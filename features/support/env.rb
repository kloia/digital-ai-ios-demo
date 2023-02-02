require 'em/pure_ruby'
require 'appium_lib'
require 'rspec'
require 'yaml'
require 'allure-cucumber'
require 'faker'
require 'open-uri'
require 'httparty'

Dir["#{Dir.pwd}/config/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/global/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/util/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/resources/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/model/**/*.rb"].each { |file| require_relative file }
Dir["#{Dir.pwd}/context/**/*.rb"].each { |file| require_relative file }

case BaseConfig.device_type
when 'local'
  $CAPS = YAML.load_file(File.expand_path("./config/device/device_config.yml"))
  `ios-deploy --bundle "#{Dir.pwd}/apps/#{$app_name}-#{$version}-#{$build_number}.ipa"`
  $CAPS[:caps][:udid] = `idevice_id -l`.strip
  $CAPS[:caps][:deviceName] = `idevicename`.strip
  $CAPS[:caps][:platformVersion] = `ideviceinfo -u $(idevice_id) | grep ProductVersion`.strip.split(" ")[1]
  $CAPS[:caps][:bundleId] = BaseConfig.app_name
when 'simulator'
  $CAPS = YAML.load_file(File.expand_path("./config/device/device_config.yml"))
  $CAPS[:caps][:udid] = `xcrun simctl getenv booted  SIMULATOR_UDID`.strip
  $CAPS[:caps][:deviceName] = `xcrun simctl getenv booted  SIMULATOR_DEVICE_NAME`.strip
  $CAPS[:caps][:platformVersion] = `xcrun simctl getenv booted  SIMULATOR_RUNTIME_VERSION`.strip
  $CAPS[:caps][:bundleId] = BaseConfig.app_name
else
  DigitalaiApiUtil.upload_ipa_to_digital_ai
  $CAPS = YAML.load_file(File.expand_path("./config/digitalai/#{BaseConfig.caps_name}.yml"))
  $CAPS[:caps]['release_version'] = BaseConfig.release_version
  $CAPS[:caps]['accessKey'] = DigitalaiConfig.digital_ai_access_key
  $CAPS[:caps][:bundleId] = BaseConfig.app_name
  $CAPS[:appium_lib]['server_url'] = "#{DigitalaiConfig.digital_ai_url}/wd/hub"
end

begin
  Appium::Driver.new($CAPS, true)
  Appium.promote_appium_methods Object

rescue Exception => e
  puts e.message
  Process.exit(0)
end

Allure.configure do |c|
  c.results_directory = 'output/allure-results'
  c.clean_results_directory = true
  c.logger = Logger.new(STDOUT, c.logging_level)
  c.environment_properties = {
    build_version: "#{BaseConfig.build_version}",
    release_version: "#{BaseConfig.release_version}",
  }
end

$wait = Selenium::WebDriver::Wait.new timeout: 60
Selenium::WebDriver.logger.level = :error