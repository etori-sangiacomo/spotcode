class DashboardController < ApplicationController

  def index
    load_recent_heard
    load_recommendations
  end

  def load_recent_heard
    current_user = User.first
    @recent_albums =  ::User.recently_heards(current_user)
  end

  # def load_recent_heard
  #   @recent_albums = current_user.recently_heards.order("created_at DESC").limit(4).map(&:album)
  # end


  def load_recommendations
    # heard_categories = @recent_albums.map(&:category)
    @recommended_albums = ::User.load_recommendations(@recent_albums)
  end
end
