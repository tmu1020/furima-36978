class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, presence: true
  # 半角英数字混合の指定
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'
  # 全角(漢字・ひらがな・カタカナ)の指定
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
    validates :last_name
    validates :first_name
  end
  # 全角(カタカナ)の指定
  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
