require 'zlib'
require 'yaml'
require 'pg'
require 'active_record'
require './models/pg_post'
require './models/redis_post'

namespace :db do
  desc 'Migrate the DB'
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate('db/migrate/')
  end

  desc 'Create the DB'
  task :create do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres',
                                                 'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc 'Drop the DB'
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres',
                                                 'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end

  desc 'Load the DB with data'
  task :seed do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)

    PgPost.destroy_all
    Ohm.flush

    Zlib::GzipReader.open(File.expand_path('../posts.yml.gz', __FILE__)) do |gzip|
      puts "Reading posts from gzipped YAML"
      @posts = YAML.load_documents(gzip.read)
    end

    puts "\nLoad the postgres DB"
    before = Time.now
    @posts.each do |post|
      PgPost.create params(post)
      print '.'
    end
    after = Time.now
    puts "\nElapsed time #{after - before}s"

    puts "\n\nLoad the redis DB"
    before = Time.now
    @posts.each do |post|
      RedisPost.create params(post)
      print '.'
    end
    after = Time.now
    puts "\nElapsed time #{after - before}s"
  end
end

def likes
  (1...1500).to_a.sample
end

def views
  (10...5000).to_a.sample
end

def params post
  if post[:author].is_a? Array
    post[:author] = post[:author].first
  end

  post.merge!({ likes: likes, views: views })

  keys = [:title, :author, :abstract, :shares, :content, :likes, :views]
  post.select { |k| keys.include? k }
end
