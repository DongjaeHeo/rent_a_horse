class DashboardsController < ApplicationController

  def show
    @bookings = current_user.bookings
    @horses = current_user.horses
  end
end
