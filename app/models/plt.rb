class Plt
include Mongoid::Document
  field :s, as: :start, type: Time
  field :d, as: :duration, type: Integer 
  attr_accessible :start, :duration
  embedded_in :deck
end
