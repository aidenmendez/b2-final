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
      @surgery4 = Surgery.create!(title: "Heart Surgery", operating_room_number: 13, day: "Wednesday")
      DoctorSurgery.create!(doctor_id: @doctor1.id, surgery_id: @surgery1.id)
      DoctorSurgery.create!(doctor_id: @doctor2.id, surgery_id: @surgery2.id)
      DoctorSurgery.create!(doctor_id: @doctor1.id, surgery_id: @surgery3.id)
      DoctorSurgery.create!(doctor_id: @doctor2.id, surgery_id: @surgery3.id)
    end

    it "I see the title and operating room number of that surgery" do
      visit surgery_path(@surgery1.id)

      expect(page).to have_content("Title: #{@surgery1.title}")
      expect(page).to have_content("Room number: #{@surgery1.operating_room_number}")
    end

    it "I see a section of the page that says 'Other surgeries happening this day of the week:'" do
      visit surgery_path(@surgery1.id)
      within("#other-surgeries-section") do
        expect(page).to have_content("Other surgeries happening this day of the week:")
      end
    end

    it "under that header I see titles of all surgeries that happen on the same day of the week as this surgery." do
      visit surgery_path(@surgery1.id)
      expect(page).to have_content("Other surgeries happening this day of the week:")
      within("#other-surgeries-section") do
        expect(page).to have_content(@surgery4.title)
      end
    end

    it "I see a field with instructions to 'Add A Doctor To This Surgery'" do
      visit surgery_path(@surgery1.id)
      expect(page).to have_content("Add Doctor to this Surgery")

    end

    it "When I input the name of an existing Doctor into that field and I click submit, I'm taken back to that surgery's show page and I see the name of that doctor listed on the page" do
      visit surgery_path(@surgery1.id)

      within("#surgery-doctors-section") do
        expect(page).to have_content(@doctor1.name)
        expect(page).not_to have_content(@doctor2.name)
      end

      within("#add-doctor-section") do
        fill_in("Name", with: @doctor2.name)
        click_on("Add")
      end

      expect(current_path).to eq(surgery_path(@surgery1.id))

      within("#surgery-doctors-section") do
        expect(page).to have_content(@doctor1.name)
        expect(page).to have_content(@doctor2.name)
      end
    end
  end
end


# (Note: You do not need to use the created_at or updated_at columns for Surgeries)