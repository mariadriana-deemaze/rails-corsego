# frozen_string_literal: true

require "rails_helper"

RSpec.describe CoursesHelper, :type => :helper do

    describe 'enrollment button helper' do 
        
        
        context "when user is logged in" do
            
            before do
                allow(helper).to receive(:current_user).and_return(user)
            end
            
            describe "course belongs to current_user" do 
                
                let!(:user)       { build(:user, id: 1) }
                let!(:course)     { build(:course, id: 1, user: user) }
                
                it "returns user progress in course" do
                    button = helper.enrollment_button(course)
                    # TODO: Change link to the actual stats page 👹
                    expect(button).to have_link("Check analytics", href:"/courses/1" )
                end
            end
            
            xdescribe "current_user is enrolled in this course" do 

                let!(:user)       { build(:user, id: 1) }
                let!(:course)     { build(:course, id: 1, user: user) }
                let!(:enrollment) { build(:enrollment, course: course, user: helper.current_user) }
                
                it "returns user progress in course" do
                    course.enrollments << enrollment

                    button = helper.enrollment_button(course)
                    expect(button).to have_link("Progress", href:"/courses/1" )
                end
            end
        end
        
        
        xcontext "when user is NOT logged in" do 
            
            before do
                allow(helper).to receive(:current_user).and_return(nil)
            end
            
            let(:course)     { build(:course, id:1) }
            
            it "displays a link for the user to check the price" do 
                button = helper.enrollment_button(course)
                expect(button).to have_link("Check price", href: "/courses/1/enrollments/new")
            end
        end

    end
end
