class User < ActiveRecord::Base
  has_many :bookmarks, dependent: :destroy
  has_many :playlists, dependent: :destroy

  has_secure_password
  validates :password, length: { in: 4..24 },
                       allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
