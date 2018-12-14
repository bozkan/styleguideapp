class Brand < ApplicationRecord
  belongs_to :account

  validates_presence_of :name
  validates :subdomain,
    presence: true,
    uniqueness: { case_sensitive: false,
      message: '%{value} is already taken' },
    exclusion: { in: %w(www admin test app assets marketing blog cdn files support help),
      message: '%{value} is reserved' },
    format: { with: /\A[a-zA-Z0-9\-_]+\z/,
      message: 'must only contain letters, numbers, and may also include dash and underscore characters' }

end
