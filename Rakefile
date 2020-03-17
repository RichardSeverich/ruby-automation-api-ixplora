# Rake config file
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'report_builder'

# Report builder tasks
desc 'Task to build the json report'
task :json_report, [:tag] do |_t, args|
  sh "cucumber -t @#{args.tag} -f json -o features/reports/#{args.tag}/report_#{args.tag}.json"
end

desc 'Task to build the html report'
task :html_report, [:tag] do |_t, args|
  ReportBuilder.configure do |config|
    config.json_path = "features/reports/#{args.tag}/"
    config.report_path = "features/reports/#{args.tag}/report_#{args.tag}"
    config.report_types = [:html]
    config.report_title = "Ixplora #{args.tag} Reports"
    config.include_images = false
  end
  ReportBuilder.build_report
end

task :reports, [:tag] do |_t, args|
  sh "rake json_report['#{args.tag}']"
  sh "rake html_report['#{args.tag}']"
end

# Rubocop default inspection task for Travis CI
task default: :rubocop

task :rubocop do
  sh 'rubocop'
end
