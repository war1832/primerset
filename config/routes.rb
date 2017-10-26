Rails.application.routes.draw do

  get 'auditoria/accesos'
  get 'auditoria/modificaciones'
  match 'consultaauditoria' => 'auditoria#consulta',:via => :post   
  
  match 'agenda' => 'reservas#agenda', date: Date.today, :via => :get
  match 'consulta' => 'reservas#consulta', :via => :get
  match 'consultaagenda' => 'reservas#agenda',:via => :post
  
  resources :cancelaciones_turnos
  resources :turnos_fijos
  match 'cancelacion' => 'turnos_fijos#cancelacion', :via => :get
  match 'cancelarturnofijo' => 'turnos_fijos#cancelar', :via => :post
  resources :reservas
  resources :canchas
  resources :tipo_canchas
  resources :clientes
  match 'consultacliente' => 'clientes#consulta',:via => :post   
  resources :tipo_clientes
  resources :user_admin
  
  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root :to => 'welcome#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
