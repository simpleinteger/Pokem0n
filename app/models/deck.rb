class Deck
  include Mongoid::Document

  # Fields
  field :n, as: :name, type: String
  field :swf, as: :setting_whitespace, type: Boolean 
  field :scs, as: :setting_case_sensitive, type: Boolean 

  # Association
  embeds_many :cards
  embeds_many :plts
  belongs_to :user


  # Security
  attr_accessible :name, :setting_whitespace, :setting_case_sensitive

  # Assocation options
  accepts_nested_attributes_for :cards
end
