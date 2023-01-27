# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, :type => :model do
  subject(:user) { build(:user) }
  
  describe "Validations" do 
    it { expect(user).to be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe 'Associations' do
    it { should have_many(:courses) }
  end

  describe 'Methods' do 
    let(:course) { create(:course) }
    let(:lesson) { create(:lesson, course: course) }
    let(:user_lesson) { create(:user_lesson, user: subject, lesson: lesson, impressions: 1) }
    
    it 'should enroll user' do 
      subject.save!
      subject.enroll_to_course(course)
      expect(subject.enrollments.count).to  eq(1)
    end
    
    it 'should add lesson' do 
      subject.save!
      subject.mark_as_viewed(lesson)
      expect(subject.user_lessons.count).to  eq(1)
    end
  
    xit 'should increment impression' do 
      #subject.courses << course
      #debugger
      #subject.save!
      #subject.mark_as_viewed(lesson)
      #expect(subject.user_lessons.count).to  eq(2)
    end

  end
end
  