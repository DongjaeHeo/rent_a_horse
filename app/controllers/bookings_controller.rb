class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :confirm]

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
    @horse = Horse.find(params[:horse_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @horse = Horse.find(params[:horse_id])
    @booking.horse = @horse

    if @horse.available?(@booking.start_date, @booking.end_date)
      if @booking.save
        redirect_to dashboard_path
      else
        redirect_to horse_path(@horse), status: :unprocessable_entity
      end
    else
      redirect_to horse_path(@horse), status: :unprocessable_entity
      flash[:alert] = "The horse is already booked on that day"
    end
  end

  def edit
    @horse = Horse.find(params[:horse_id])
    @user = User.find(@booking.user_id)
  end

  def update
    @horse = Horse.find(params[:horse_id])
    @user = User.find(@booking.user_id)
    @booking.errors.add(:booking, 'Horse is already booked') unless @horse.available?(params[:booking][:start_date], params[:booking][:end_date])
    if @booking.update(booking_params)
      redirect_to dashboard_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def confirm
    @booking.confirm!
    redirect_to dashboard_path
  end

  def destroy
    @booking.destroy

    # redirect_to horse_bookings_path(@booking.horse), status: :see_other
    redirect_to dashboard_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :confirmed)
  end
end
