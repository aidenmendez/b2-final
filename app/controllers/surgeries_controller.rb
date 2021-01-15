class SurgeriesController < ApplicationController
  def index
    @surgeries = Surgery.all
  end

  def show
    @surgery = Surgery.find(params[:id])
    @other_surgeries = @surgery.find_others
  end

  def update
    doctor = Doctor.where(name: params[:surgery][:name]).first
    DoctorSurgery.create(doctor_id: doctor.id, surgery_id: params[:id])
    redirect_to(surgery_path(params[:id]))
  end
end