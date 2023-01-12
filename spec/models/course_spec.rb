# frozen_string_literal: true

require "rails_helper"

RSpec.describe Course, :type => :model do
  subject { FactoryBot.build(:course) }
  
  describe "Validations" do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    xit { should validate_length_of(:description).is_at_least(5)}
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:language) }    
  end

  describe 'Associations' do
    it { should have_many(:lesson) }
    it { should belong_to(:user) }
  end
end
  