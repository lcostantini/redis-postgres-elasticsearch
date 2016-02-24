# Description
This application was designed to test the response time for searches between
**Redis** and **Postgres** against **Elasticsearch**.

I choose *ActiveRecord for PostgreSQL*, *Ohm for Redis* and of course *Elasticsearch*.

There is a task in Rakefile that loads the DBs and the indexes in Elasticsearch
with many posts.

For the endpoints I choose Cuba.

* To use ActiveRecord without Rails I followed [this](https://github.com/jwo/ActiveRecord-Without-Rails) repository.

* The data used for the purpose of the test are taken from [this](https://github.com/elastic/elasticsearch-rails/blob/master/elasticsearch-rails/lib/rails/templates/articles.yml.gz) repository elasticsearch-rails.

# Usage
Run the tasks in Rakefile.

1. To create the database using ActiveRecord: rake db:create
2. To run the migrations for ActiveRecord: rake db:migrate
3. To load the DBs with data: rake db:seed

Done!. You have in Redis, PostgreSQL and Elasticsearch all the data.
