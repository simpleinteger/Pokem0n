class Deck
  include Mongoid::Document

  # Fields
  field :n, as: :name, type: String

  # Association
  embeds_many :cards
  embeds_many :plts
  belongs_to :user


  # Security
  attr_accessible :name

  # Assocation options
  accepts_nested_attributes_for :cards
end
