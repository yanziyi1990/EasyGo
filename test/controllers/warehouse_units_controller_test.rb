require 'test_helper'

class WarehouseUnitsControllerTest < ActionController::TestCase
  setup do
    @warehouse_unit = warehouse_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warehouse_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warehouse_unit" do
    assert_difference('WarehouseUnit.count') do
      post :create, warehouse_unit: { count: @warehouse_unit.count, name: @warehouse_unit.name, sku: @warehouse_unit.sku, status: @warehouse_unit.status }
    end

    assert_redirected_to warehouse_unit_path(assigns(:warehouse_unit))
  end

  test "should show warehouse_unit" do
    get :show, id: @warehouse_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warehouse_unit
    assert_response :success
  end

  test "should update warehouse_unit" do
    patch :update, id: @warehouse_unit, warehouse_unit: { count: @warehouse_unit.count, name: @warehouse_unit.name, sku: @warehouse_unit.sku, status: @warehouse_unit.status }
    assert_redirected_to warehouse_unit_path(assigns(:warehouse_unit))
  end

  test "should destroy warehouse_unit" do
    assert_difference('WarehouseUnit.count', -1) do
      delete :destroy, id: @warehouse_unit
    end

    assert_redirected_to warehouse_units_path
  end
end
