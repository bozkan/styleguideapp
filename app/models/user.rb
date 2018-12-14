class User < ApplicationRecord

  #validates_presence_of :email, :password
  has_one :account, foreign_key: :owner_id
  
end
