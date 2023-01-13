require 'rails_helper'

RSpec.describe "enrollments/new", type: :view do
  before(:each) do
    assign(:enrollment, Enrollment.new(
      user: nil,
      course: nil,
      rating: 1,
      review: "MyText",
      price: 1
    ))
  end

  it "renders new enrollment form" do
    render

    assert_select "form[action=?][method=?]", enrollments_path, "post" do

      assert_select "input[name=?]", "enrollment[user_id]"

      assert_select "input[name=?]", "enrollment[course_id]"

      assert_select "input[name=?]", "enrollment[rating]"

      assert_select "textarea[name=?]", "enrollment[review]"

      assert_select "input[name=?]", "enrollment[price]"
    end
  end
end
