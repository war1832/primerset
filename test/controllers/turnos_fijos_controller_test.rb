require 'test_helper'

class TurnosFijosControllerTest < ActionController::TestCase
  setup do
    @turnos_fijo = turnos_fijos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:turnos_fijos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create turnos_fijo" do
    assert_difference('TurnosFijo.count') do
      post :create, turnos_fijo: { cancha_id: @turnos_fijo.cancha_id, cliente_id: @turnos_fijo.cliente_id, dia_semana: @turnos_fijo.dia_semana, hora_fin: @turnos_fijo.hora_fin, hora_inicio: @turnos_fijo.hora_inicio }
    end

    assert_redirected_to turnos_fijo_path(assigns(:turnos_fijo))
  end

  test "should show turnos_fijo" do
    get :show, id: @turnos_fijo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @turnos_fijo
    assert_response :success
  end

  test "should update turnos_fijo" do
    patch :update, id: @turnos_fijo, turnos_fijo: { cancha_id: @turnos_fijo.cancha_id, cliente_id: @turnos_fijo.cliente_id, dia_semana: @turnos_fijo.dia_semana, hora_fin: @turnos_fijo.hora_fin, hora_inicio: @turnos_fijo.hora_inicio }
    assert_redirected_to turnos_fijo_path(assigns(:turnos_fijo))
  end

  test "should destroy turnos_fijo" do
    assert_difference('TurnosFijo.count', -1) do
      delete :destroy, id: @turnos_fijo
    end

    assert_redirected_to turnos_fijos_path
  end
end
