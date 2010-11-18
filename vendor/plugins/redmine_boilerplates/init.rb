require 'redmine'

Redmine::Plugin.register :redmine_boilerplates do
    name 'Redmine Boilerplates plugin'
    author 'Gordon B. Isnor'
    description 'This is a plugin to add boilerplate content to projects issues etc'
    version '0.0'

    requires_redmine :version_or_higher => '0.9.0'

    menu :admin_menu, 'Boilerplates', "/boilerplates"

end

