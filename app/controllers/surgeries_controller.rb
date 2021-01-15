class SurgeriesController < ApplicationController
  def index
    @surgeries = Surgery.all
  end

  def show
    @surgery = Surgery.find(params[:id])
    @other_surgeries = @surgery.find_others
  end
end