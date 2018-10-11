require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @house = houses(:one)
    @house_photo = fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'house.png'),'image/png')

    @house.image_path.attach(@house_photo)
    @house.save

    sign_in users(:one)
  end

  test "should get index" do
    get houses_url
    assert_response :success
  end

  test "should get new" do
    get new_house_url
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post houses_url, params: { house: { area: @house.area, company_id: @house.company_id, email: @house.email, floors: @house.floors, has_basement: @house.has_basement, image_path: @house_photo, location: @house.location, owner: @house.owner, phone: @house.phone, price: @house.price, style: @house.style, user_id: @house.user_id, year_built: @house.year_built } }
    end

    assert_redirected_to house_url(House.last)
  end

  test "should show house" do
    get house_url(@house)
    assert_response :success
  end

  test "should get edit" do
    get edit_house_url(@house)
    assert_response :success
  end

  test "should update house" do
    patch house_url(@house), params: { house: { area: @house.area, company_id: @house.company_id, email: @house.email, floors: @house.floors, has_basement: @house.has_basement, image_path: @house_photo, location: @house.location, owner: @house.owner, phone: @house.phone, price: @house.price, style: @house.style, user_id: @house.user_id, year_built: @house.year_built } }
    assert_redirected_to house_url(@house.id)
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete house_url(@house)
    end

    assert_redirected_to houses_url
  end
end
