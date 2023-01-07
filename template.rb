

# Rails Application Templates — Ruby on Rails Guides
# https://guides.rubyonrails.org/rails_application_templates.html

# template.rb

# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) + 
    [File.expand_path(File.dirname(__FILE__))]
end
  

inject_into_file 'Gemfile' do
  <<-CODE
    gemfiles = %w{Gemfiles/Gemfile-ext Gemfiles/Gemfile-ext}
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

# copy_file "app/controllers/application_controller.rb", "app/controllers/application_controller.rb"
copy_file "app/resources/application_resource.rb", "app/resources/application_resource.rb"

copy_file "Gemfiles/Gemfile-excel", "Gemfiles/Gemfile-excel"
copy_file "Gemfiles/Gemfile-ext", "Gemfiles/Gemfile-ext"

# copy_file "config/database.pg.yml", "config/database.yml"
# copy_file "db/sql/database.sql", "db/sql/database.sql"

# copy_file "docker-compose.yml"

copy_file ".tool-versions"
