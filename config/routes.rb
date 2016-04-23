Rails.application.routes.draw do
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

  namespace :collections do

    resources :queues, only: [:show] do
      collection do
        get :search
        post :search
        post :create_inbound_item
      end

      resources :items, only: [:show] do
        member do
          post :requeue
          post :close
          patch :update_account_collection_status
          patch :update_entity_collection_status
          patch :update_entity_language
          patch :update_static_note
          get :show_static_note_history
        end

        resources :calls
        resources :letters
        resources :payoffs do
          collection do
            post :preview
            post :reset
          end
        end
        resources :phones
      end
    end

    match 'reports/my_team_call_results' => 'reports#my_team_call_results', via: [:get, :post]
    match 'reports/user_work_queue_activity' => 'reports#user_work_queue_activity', via: [:get, :post]
    match 'reports/call_result_details' => 'reports#call_result_details', via: [:get, :post]
    match 'reports/all_teams_call_results' => 'reports#all_teams_call_results', via: [:get, :post]

    resources :signatures
    resources :status_updates, only: [:new, :create]
  end

end
