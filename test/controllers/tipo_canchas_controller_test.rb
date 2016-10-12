require 'test_helper'

class TipoCanchasControllerTest < ActionController::TestCase
  setup do
    @tipo_cancha = tipo_canchas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_canchas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_cancha" do
    assert_difference('TipoCancha.count') do
      post :create, tipo_cancha: { descripcion: @tipo_cancha.descripcion }
    end

    assert_redirected_to tipo_cancha_path(assigns(:tipo_cancha))
  end

  test "should show tipo_cancha" do
    get :show, id: @tipo_cancha
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_cancha
    assert_response :success
  end

  test "should update tipo_cancha" do
    patch :update, id: @tipo_cancha, tipo_cancha: { descripcion: @tipo_cancha.descripcion }
    assert_redirected_to tipo_cancha_path(assigns(:tipo_cancha))
  end

  test "should destroy tipo_cancha" do
    assert_difference('TipoCancha.count', -1) do
      delete :destroy, id: @tipo_cancha
    end

    assert_redirected_to tipo_canchas_path
  end
end
