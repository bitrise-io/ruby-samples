class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,     type: String
  field :category, type: String
  field :metadata, type: Hash, default: {}

  validates :name,     presence: true
  validates :category, presence: true
end
