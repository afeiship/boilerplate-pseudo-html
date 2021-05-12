require_relative "./cook"

namespace :cook do
  desc "generate detail"
  task :detail => :environment do
    Cook.start("detail")
  end

  desc "generate download"
  task :download => :environment do
    Cook.start("download")
  end
end
