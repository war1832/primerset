require 'test_helper'

class TipoClientesControllerTest < ActionController::TestCase
  setup do
    @tipo_cliente = tipo_clientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_clientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_cliente" do
    assert_difference('TipoCliente.count') do
      post :create, tipo_cliente: { descripcion: @tipo_cliente.descripcion }
    end

    assert_redirected_to tipo_cliente_path(assigns(:tipo_cliente))
  end

  test "should show tipo_cliente" do
    get :show, id: @tipo_cliente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_cliente
    assert_response :success
  end

  test "should update tipo_cliente" do
    patch :update, id: @tipo_cliente, tipo_cliente: { descripcion: @tipo_cliente.descripcion }
    assert_redirected_to tipo_cliente_path(assigns(:tipo_cliente))
  end

  test "should destroy tipo_cliente" do
    assert_difference('TipoCliente.count', -1) do
      delete :destroy, id: @tipo_cliente
    end

    assert_redirected_to tipo_clientes_path
  end
end
