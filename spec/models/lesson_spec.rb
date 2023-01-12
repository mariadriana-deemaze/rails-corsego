# frozen_string_literal: true

require "rails_helper"

RSpec.describe Lesson, :type => :model do
  subject { FactoryBot.build(:lesson) }
  
  describe "Validations" do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'Associations' do
    it { should belong_to(:course) }
  end
end
  