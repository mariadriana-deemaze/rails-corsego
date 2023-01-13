# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  subject { FactoryBot.build(:enrollment) }
  
  describe "Validations" do 
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:course) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end
end
