require 'cuba'
require 'cuba/render'
require './models/pg_post'
require './models/redis_post'

Cuba.plugin Cuba::Render
Cuba.use Rack::Static, urls: ['/css'], root: 'public'

Cuba.define do
  on get do
    on root do
     render 'index'
    end

    on 'redis' do
      on root do
        render 'redis', posts: RedisPost.all.to_a
      end

      on params('q') do |query|

      end
    end

    on 'postgres' do
      on root do
        render 'postgres', posts: PgPost.all
      end

      on params('q') do |query|

      end
    end
  end
end
