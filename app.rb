require 'cuba'
require 'cuba/render'
require './models/pg_post'
require './models/redis_post'

Cuba.plugin Cuba::Render
Cuba.use Rack::Static, urls: ['/css'], root: 'public'

Cuba.define do
  on get do
    on root do
     render 'index', posts: PgPost.all, total: nil, elapsed_time: nil
    end

    on 'redis' do
      on root do
        before = Time.now
        posts = RedisPost.all.to_a
        after = Time.now
        render 'redis', posts: posts, total: posts.count, elapsed_time: after - before
      end
    end

    on 'postgres' do
      on root do
        before = Time.now
        posts = PgPost.all
        after = Time.now
        render 'postgres', posts: posts, total: posts.count, elapsed_time: after - before
      end
    end
  end
end
