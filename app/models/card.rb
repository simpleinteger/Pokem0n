class Card
  include Mongoid::Document
  field :q, as: :question, type: String
  field :a, as: :answer, type: String
  attr_accessible :question, :answer
  embedded_in :deck
end
