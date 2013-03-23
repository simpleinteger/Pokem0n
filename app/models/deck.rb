class Deck
  include Mongoid::Document
  field :n, as: :name, type: String
  embeds_many :cards
  embeds_many :plts
  attr_accessible :name
  accepts_nested_attributes_for :cards, :plts
end
