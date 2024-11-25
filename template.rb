

# Rails Application Templates — Ruby on Rails Guides
# https://guides.rubyonrails.org/rails_application_templates.html

# template.rb

# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

gemfiles = %W{
  Gemfiles/Gemfile-excel
  Gemfiles/Gemfile-ext
  Gemfiles/Gemfile-migration
}

inject_into_file 'Gemfile' do
<<-CODE
gemfiles = %w{#{gemfiles.join(' ')}}

gemfiles.each do |gemfile|
  if File.exist?(gemfile)
    # or instance_eval File.read(gemfile)
    eval_gemfile gemfile
  else
    puts("\e[31mWarning: " + gemfile + " not found!\e[0m")
  end
end
CODE
end

gemfiles.each do |gemfile|
  copy_file gemfile, gemfile
end

copy_file ".active_record_doctor.rb", ".active_record_doctor.rb"
# copy_file ".tool-versions"

# copy_file "app/controllers/application_controller.rb", "app/controllers/application_controller.rb"
copy_file "app/resources/application_resource.rb", "app/resources/application_resource.rb"



# copy_file "config/database.pg.yml", "config/database.yml"

copy_file "config/initializers/generators.rb", "config/initializers/generators.rb"
copy_file "config/initializers/table_definition.rb", "config/initializers/table_definition.rb"

# copy_file "db/sql/database.sql", "db/sql/database.sql"

# copy_file "docker-compose.yml"

#
after_bundle do
  generate('strong_migrations:install')
end
