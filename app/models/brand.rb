class Brand < ApplicationRecord
  belongs_to :account
  has_many :colors, dependent: :destroy
  has_many :fonts, dependent: :destroy
  has_many :logos, dependent: :destroy
  has_many :components, dependent: :destroy
  has_many :color_categories, dependent: :destroy

  validates_presence_of :name
  validates :subdomain,
    presence: true,
    uniqueness: { case_sensitive: false,
      message: '%{value} is already taken' },
    exclusion: { in: %w(www admin test app assets marketing blog cdn files support help),
      message: '%{value} is reserved' },
    format: { with: /\A[a-zA-Z0-9\-_]+\z/,
      message: 'must only contain letters, numbers, and may also include dash and underscore characters' }

  after_create_commit :setup_brand

  def primary_logo
    if logos.exists?
      logos.order(created_at: :asc).first
    end
  end

  private

    def setup_brand
      # @todo Trigger Cloudflare Job
      self.color_categories.create([{
        name:'Primaries'
      },{
        name:'Neutrals'
      },{
        name:'Supporting'
      }])
    end

end
