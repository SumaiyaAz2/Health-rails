class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, on: :create, message: "can't be blank"
  validates_presence_of :license, on: :create, message: "can't be blank"
  validates_presence_of :password, on: :create, message: "can't be blank"

  validates_uniqueness_of :email
  validates_uniqueness_of :license
end
