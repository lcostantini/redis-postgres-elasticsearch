![](https://github.com/lcostantini/redis-postgres-elasticsearch/blob/master/gif-lcostantini-redis-postgres-elasticsearch.gif)

# Description
This application was designed to test the response time for searches using
**Redis**, **PostgreSQL** and **Elasticsearch**.

I guess you know about Elasticsearch, if not you can read about
it [here](https://www.elastic.co/products/elasticsearch).

### Why I do that?
Well... most of the time I work on projects with Rails and the client sometimes
ask me if I can add Elasticsearch to make a query for some or multiple fields
or whatever reason and I know the power of Elasticsearch has but I always asked
myself if there is any difference of time using ActiveRecord or Elasticsearch if
the query is not to complex and the DB isn't to big (I'm going to say: *big* is
over a million of lines in a table). To resolve this question I created this
application but why Redis? Well if I'm comparing an SQL DB against the Elasticsearch
service why not add an NoSQL DB and test everything, right?.

### This is what I used
To connect with databases I have selected the most commonly used ORM:
* [ActiveRecord](https://github.com/soveran/ohm) for PostgreSQL.
* [Ohm](https://github.com/soveran/ohm) for [Redis](http://redis.io/).

For Elasticsearch I used the [service](https://www.elastic.co/downloads/elasticsearch).

---

To use ActiveRecord without Rails I followed [this](https://github.com/jwo/ActiveRecord-Without-Rails) repository.

---

For the application I used [Cuba](https://github.com/soveran/cuba), because it's a
microframework for Ruby and just needed to create a pair of endpoints.

### Seed
To load the DBs and Elasticsearch with data I have a file with information to
create 929 posts. You can use a task to load that data.

```
rake db:seed
```

* The file used for this purpose was taken from [elasticsearch-rails](https://github.com/elastic/elasticsearch-rails/blob/master/elasticsearch-rails/lib/rails/templates/articles.yml.gz) repository.

The posts have a *Title*, *Author*, *Abstract*, *Shares*, *Content*, *Likes* and *Views*.

### ActiveRecord
You need to create the DB and run the migrations, to do that tthere is two task as the same way you use in Rails
```
rake db:create
rake db:migrate
```

even if you want to drop the DB you can run:
```
rake db:drop
```

# Usage
You need to have installed PostgreSQL, Redis and Elasticsearch. After you have everything installed and running you need to run the tasks in the Rakefile.

1. To create the database using ActiveRecord: **rake db:create**
2. To run the migrations for ActiveRecord: **rake db:migrate**
3. To load the DBs with data: **rake db:seed**

Done!. You have in Redis, PostgreSQL and Elasticsearch all the data.
