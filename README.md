# <a href="https://digital.ai/products/continuous-testing/">digital.ai</a> iOS Test Automation Demo

This project includes ios test automation codes of device farm integration of <a href="https://digital.ai/products/continuous-testing/">digital.ai</a>  continuous testing platform.

# Tool stack

* **Ruby** - Development language
* **RubyMine IDE** - Development IDE
* **Allure** Multi-language test report tool
* **Cucumber** - Gherkin Syntax Framework
* **RSpec** - Assertion & Validation Framework
* **Appium** - Mobile Test Automation Tool
* **<a href="https://digital.ai/products/continuous-testing/">digital.ai continuous testing</a>** - Device Farm

# Topic

* Access to device farm with remote connection

* Upload the application with <a href="https://docs.experitest.com/display/TE/Rest+API">digital.ai</a>'s api to the device farm before running the scenarios

* Linking the video records to the report

# Installation

* Ruby must be installed. <a href="https://www.ruby-lang.org/en/downloads/">Link to install</a>

* NodeJs must be installed.
   ```
   You can install it by running the following command from the terminal.
   brew install node
   ```
  
* Appium must be installed. Appium Desktop installation <a href="https://appium.io/downloads.html">link to install</a>
   ```
   You can install it by running the following command from CMD.
   npm install -g appium
   ```

* If you run local, device ideviceinstaller must be installed.
   ```
   You can install it by running the following command from CMD.
   brew install ideviceinstaller
   ```

* The following commands are run in the project directory to install the necessary libraries.
  ```
  gem install bundler
  bundle install
  ```
  
# Project Configuration

* To run with <a href="https://digital.ai/products/continuous-testing/">digital.ai</a> devices <a href="https://accounts.seetest.io/signup">free trial account</a> must be created.

* digital_ai_url and digital_ai_access_key fields must be added in the digitalai_config file to access cloud devices.

* device_type field must be cloud in the base_config file to access cloud devices.

* device_type field must be local in the base_config file to access local device.


# Test Run

1. It can be run based on scenario or feature with the green RUN button on the IDE.

2. Run from terminal with scenario or feature tag in project directory:
   
   `cucumber --tag @login`

3. Run parallel from terminal with scenario or feature tag in project directory:
   
   `ruby cucumber_parallel_run.rb "login"`


# Reporting
* Allure report is used as a reporting tool.

* Allure must be installed on your PC to create an Allure report..

    * Mac install

      `brew install allure`

    * Windows install

        * Powershell opens. The following command is run. Scoop install is done.

          `iwr -useb get.scoop.sh | iex`

        * After the successful installation of Scoop, the command line opens. The following command is run. Allure is installed.

          `scoop install allure`


* To generate an Allure report, the following command is run by giving the path to the allure-results folder in the project directory.

  `allure serve output/allure-results `


# Project Folder Structure

```
.
├── Gemfile                                                # Management of the libraries to be used in the project
├── README.md
├── apps
│   └── com.experitest.ExperiBank_1.0-6117.ipa
├── config                                                 # Configurations of the project
│   ├── base
│   │   └── base_config.rb
│   ├── device                                             # Device configurations of the project
│   │   └── device_config.yml
│   └── digitalai                                          # Device farm configurations of the project
│       ├── digitalai_config.rb
│       └── digitalai_config.yml
├── cucumber.yml                                           # Run configurations
├── features
│   ├── pages
│   │   └── login
│   │       └── login_page.rb
│   ├── resources
│   │   └── credentials.rb
│   ├── step_definitions
│   │   └── login
│   │       └── login_steps.rb
│   ├── support
│   │   ├── env.rb
│   │   └── hooks.rb
│   └── tests
│       └── login.feature                                  # Directory of scenarios in #Gherkin Synxtax
└── util
    ├── api_util.rb
    ├── digital_ai_api_util.rb
    ├── loggers.rb
    └── page_helper.rb

```
