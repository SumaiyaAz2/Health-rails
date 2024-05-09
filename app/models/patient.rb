class Patient < ApplicationRecord
  has_many :records

  validates_presence_of :nid, on: :create, message: "can't be blank"
  
  validates_uniqueness_of :nid
end
