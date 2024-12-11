# Use UUID for primary key with Rails and Postgres · Daniela Baron
# https://danielabaron.me/blog/rails-uuid-primary-key-postgres/

# config/initializers/generators.rb
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
