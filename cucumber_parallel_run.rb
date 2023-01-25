require_relative 'config/base/base_config'
puts "Started At #{Time.now}"
all_yml_file = []
pool_thread = []
tags= ARGV[0]
puts "Tags #{tags}"
Dir["#{Dir.pwd}/config/digitalai/*.yml"].each do |file_path|
  all_yml_file << File.basename(file_path, File.extname(file_path))
end

 all_yml_file.each { |file|
    puts "File At #{file}"
    `mkdir -p cucumber-report/#{file}`
    if tags.nil?
      pool_thread << Thread.new { `bundle exec cucumber features/ device_type=#{BaseConfig.device_type} caps_name=#{file} --format json --out=cucumber-report/#{file}/cucumber#{file}.json ` }
    else
      pool_thread << Thread.new { `bundle exec cucumber features/ --tags #{tags} device_type=#{BaseConfig.device_type} caps_name=#{file} --format json --out=cucumber-report/#{file}/cucumber#{file}.json` }
    end
  }

  pool_thread.each { |thread|
    thread.join
  }


puts "Ended At #{Time.now}"
