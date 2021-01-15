require 'rails_helper'

RSpec.describe Surgery, type: :model do
  describe 'relationships' do
    it {should have_many :doctor_surgeries}
    it {should have_many(:doctors).through(:doctor_surgeries)}
  end

  describe "find_others" do
    before do
      # @hospital1 = Hospital.create!(name: "Seattle Grace")
      # @doctor1 = Doctor.create!(hospital_id: @hospital1.id, name: "Philip McGrew", specialty:"Cardiac", university: "University of Washington")
      # @doctor2 = Doctor.create!(hospital_id: @hospital1.id, name: "Robert Cargill", specialty:"Brain", university: "University of Washington")
      @surgery1 = Surgery.create!(title: "Brain Surgery", operating_room_number: 3, day: "Wednesday")
      @surgery2 = Surgery.create!(title: "Heart Surgery", operating_room_number: 16, day: "Wednesday")
      @surgery3 = Surgery.create!(title: "Heart and brain surgery (wow)", operating_room_number: 11, day: "Friday")
      @surgery4 = Surgery.create!(title: "Heart Surgery", operating_room_number: 13, day: "Wednesday")
    end

    it "returns other surgeries happening on same day" do
      results = @surgery1.find_others
      expected_results = [@surgery2, @surgery4]

      expect(results).to eq(expected_results)
      expect(results).to not_include(@surgery4)
    end
  end
end
