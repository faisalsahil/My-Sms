class Message < ActiveRecord::Base
  attr_accessible :name, :number
  validates_presence_of :name, :number
end
