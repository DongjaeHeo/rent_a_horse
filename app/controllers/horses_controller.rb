class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy]
  def index
    @horses = Horse.all
  end

  def new
    @horse = Horse.new
  end

  def create
    @user = User.find(current_user.id)
    @horse = Horse.new(horse_params)
    @horse.user = @user
    if @horse.save
      redirect_to horse_path(@horse)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @horse.update(horse_params)
      redirect_to horse_path(@horse)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @horse.destroy

    redirect_to horses_path, status: :see_other
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :location, :colour, :breed, :discipline, :description, :height, :photo)
  end

  def set_horse
    @horse = Horse.find(params[:id])
  end

end
