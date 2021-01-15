require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the surgery index page" do
    before(:each) do
      @hospital1 = Hospital.create!(name: "Seattle Grace")
      @doctor1 = Doctor.create!(hospital_id: @hospital1.id, name: "Philip McGrew", specialty:"Cardiac", university: "University of Washington")
      @doctor2 = Doctor.create!(hospital_id: @hospital1.id, name: "Robert Cargill", specialty:"Brain", university: "University of Washington")
      @surgery1 = Surgery.create!(title: "Brain Surgery", operating_room_number: 3, day: "Wednesday")
      @surgery2 = Surgery.create!(title: "Heart Surgery", operating_room_number: 16, day: "Tuesday")
      @surgery3 = Surgery.create!(title: "Heart and brain surgery (wow)", operating_room_number: 11, day: "Friday")
      DoctorSurgery.create!(doctor_id: @doctor1.id, surgery_id: @surgery1.id)
      DoctorSurgery.create!(doctor_id: @doctor2.id, surgery_id: @surgery2.id)
      DoctorSurgery.create!(doctor_id: @doctor1.id, surgery_id: @surgery3.id)
      DoctorSurgery.create!(doctor_id: @doctor2.id, surgery_id: @surgery3.id)
    end

    it "I see the title of all surgeries" do
      visit surgeries_path

      expect(page).to have_content(@surgery1.title)
      expect(page).to have_content(@surgery2.title)
      expect(page).to have_content(@surgery3.title)
    end

    it "And for each surgery I see the names of all doctors performing that surgery" do
      visit surgeries_path

      within("#surgery-section-#{@surgery1.id}") do
        expect(page).to have_content(@doctor1.name)
      end
      within("#surgery-section-#{@surgery2.id}") do
        expect(page).to have_content(@doctor2.name)
      end
      within("#surgery-section-#{@surgery3.id}") do
        expect(page).to have_content(@doctor1.name)
        expect(page).to have_content(@doctor1.name)
      end
    end

    it "I can click on any surgery title to take me to that surgery’s show page" do
      visit surgeries_path

      click_link(@surgery1.title)
      expect(current_path).to eq(surgery_path(@surgery1.id))
    end
  end
end