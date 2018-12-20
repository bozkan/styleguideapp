class Invite < ApplicationRecord
  belongs_to :account
  belongs_to :brand

  acts_as_tenant(:brand)

  before_create :generate_token

  validates_presence_of :email

  private
    def generate_token
      self.token    = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
