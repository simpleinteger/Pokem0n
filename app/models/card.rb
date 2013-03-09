class Card
  include Mongoid::Document
  field :q, as: :question, type: String
  field :a, as: :answer, type: String
  field :t, as: :time, type: String 
  attr_accessible :question, :answer, :time
  embedded_in :deck
end
