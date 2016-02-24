require 'cuba'
require 'cuba/render'
require './models/pg_post'
require './models/redis_post'

Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on root do
      res.write partial "index"
    end

    on 'redis' do
      on root do

      end

      on params('q') do |query|

      end
    end

    on 'postgres' do
      on root do

      end

      on params('q') do |query|

      end
    end
  end
end
