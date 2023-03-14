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
        redirect_to horse_booking_path(@horse, @booking)
      else
        render :new, status: :unprocessable_entity
      end
    else
      @booking.errors.add(:booking, 'Horses is booked')
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @horse = Horse.find(params[:horse_id])
    @user = User.find(@booking.user_id)
  end

  def update
    @horse = Horse.find(params[:horse_id])
    @user = User.find(@booking.user_id)
    @booking_new = Booking.new(booking_params)
    if @horse.available?(@booking_new.start_date, @booking_new.end_date)
      @booking.update(booking_params)
      redirect_to horse_booking_path(@horse, @booking)
    else
      # if @user == current_user
      #   @booking.update(booking_params)
      # end
      @booking.errors.add(:booking, 'Horses is booked')
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

    redirect_to horse_bookings_path(@booking.horse), status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :confirmed)
  end
end
