class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name,  presence:true, length: {maximum: 20, minimum: 2}
  validates :introduction,         length: {maximum: 50}

  has_many :books,         dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人

      # ユーザーをフォローする
    def follow(user_id)
      follower.create(followed_id: user_id)
    end

    # ユーザーのフォローを外す
    def unfollow(user_id)
      follower.find_by(followed_id: user_id).destroy
    end

    # フォローしていればtrueを返す
    def following?(user)
      following_user.include?(user)
    end

    def self.search(search, word)
      if search == "forward_match"
        @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
        @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
        @user = User.where(name: word)
      elsif search == "partial_match"
        @user = User.where("name LIKE?", "%#{word}%")
      else
        @user = User.all
      end
    end



end
