class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy, :mark_done]

  def index
    @habits = current_user.habits
  end

  def show; end

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user = current_user
    if @habit.save
      redirect_to habits_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @habit.update(habit_params)
    redirect_to habit_path(@habit)
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, status: :see_other
  end

  def click
    @habit.change_state
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name)
  end
end
