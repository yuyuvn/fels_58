class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.following_activities.page(params[:page])
        .per Settings.activities.per_page
      respond_to :html, :js
    end
  end
end
