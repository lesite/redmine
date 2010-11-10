config.load_paths += %W( #{RAILS_ROOT}/app/middleware )

config.gem 'i18n', :version => '0.3.7'
config.gem "capistrano-ext", :lib => "capistrano"
config.gem 'mislav-will_paginate', :version => '2.3.6', :lib => 'will_paginate', :source => 'http://gems.github.com'
config.gem 'mime-types', :lib => 'mime/types'