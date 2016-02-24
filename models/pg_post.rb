require 'active_record'

class PgPost < ActiveRecord::Base
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
end
