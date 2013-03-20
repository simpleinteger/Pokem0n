class Deck
  include Mongoid::Document
  field :n, as: :name, type: String
  embeds_many :cards
  attr_accessible :name
  accepts_nested_attributes_for :cards
end
