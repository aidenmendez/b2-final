require 'rails_helper'

RSpec.describe Surgery, type: :model do
  describe 'relationships' do
    it {should have_many :doctor_surgeries}
    it {should have_many(:doctors).through(:doctor_surgeries)}
  end
end
