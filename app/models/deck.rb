class Deck
  include Mongoid::Document
  field :n, as: :name, type: String
  field :t, as: :time, type: Integer 
  embeds_many :cards
  attr_accessible :name,:time
  accepts_nested_attributes_for :cards
end
