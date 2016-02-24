require 'ohm'

class RedisPost < Ohm::Model
  attribute :author
  attribute :title
  attribute :abstract
  attribute :content
  attribute :likes
  attribute :views
  attribute :shares

  index :author
  index :title
  index :abstract
  index :content
  index :likes
  index :views
  index :shares
end
