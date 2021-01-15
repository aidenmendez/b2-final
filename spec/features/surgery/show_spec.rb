require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a surgery's show page" do
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

    it "I can click on any surgery title to take me to that surgery’s show page" do
      visit surgery_path(@surgery1.id)

      click_link(@surgery1.name)
      expect(current_path).to eq(surgery_path(@surgery1.id))
    end

    it "And on the surgery show page I see the title and operating room number of that surgery" do
      visit surgery_path(@surgery1.id)

      expect(page).to have_content("Title: #{@surgery1.title}")
      expect(page).to have_content("Room number: #{@surgery1.operating_room_number}")
    end

    it "And I see a section of the page that says 'Other surgeries happening this day of the week:'" do
      visit surgery_path(@surgery1.id)
    end

    it "And under that header I see titles of all surgeries that happen on the same day of the week as this surgery." do
      visit surgery_path(@surgery1.id)
    end
  end
end

# User Story 2 , Surgery Show Page
# As a visitor
# When I visit the surgery index page
# I can click on any surgery title to take me to that surgery’s show page
# And on the show page I see the title and operating room number of that surgery
# And I see a section of the page that says "Other surgeries happening this day of the week:"
# And under that header I see titles of all surgeries that happen on the same day of the week as this surgery.
# (Note: You do not need to use the created_at or updated_at columns for Surgeries)