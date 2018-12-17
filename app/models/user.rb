class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites
  has_many :recently_heards

  def self.recently_heards(current_user)
    current_user.recently_heards.order(created_at: :desc).limit(4).map(&:album)
  end

  def self.load_recommendations(recent_albums)
    heard_categories = recent_albums.map(&:category)
    Album.joins(:category, :songs)
         .where(category: heard_categories)
         .order("songs.played_count")
         .select("distinct albums.*")
         .limit(4)
  end
end