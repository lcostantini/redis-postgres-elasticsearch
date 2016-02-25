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

    on 'search', param('q'), param('db') do |query, db|
      case db
      when 'in Redis'
        before = Time.now
        posts = RedisPost.find(author: query.upcase).to_a
        after = Time.now
      when 'in Postgres'
        before = Time.now
        posts = PgPost.where("author = ?", query.upcase)
        after = Time.now
      else
        res.write 'Elasticsearch'
      end
      render 'index', posts: posts, total: posts.count, elapsed_time: after - before
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
