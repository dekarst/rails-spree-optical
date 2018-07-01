Rails.application.routes.draw do
    # scope '(:locale)', locale: /en|es|fr/ do
        root 'pages#home'

        mount Spree::Core::Engine, at: '/'
        mount Ckeditor::Engine => '/ckeditor'

        resources :taxon_searches
        resources :lenses, only: :create
        resources :prescriptions, only: :create
        resources :options, only: :create
        resources :contacts, only: [:new, :create]

        get 'variants/:id/price', to: 'variants#price', as: :variant_price

        get 'options/allowed_lenses', to: 'options#allowed_lenses', as: :allowed_lenses

        get 'add_to_wishlist/:product_id', to: 'wishlists#create', as: :add_to_wishlist
        get 'remove_from_wishlist/:product_id', to: 'wishlists#destroy', as: :remove_from_wishlist

        post 'rate', to: 'rater#create', as: 'rate'

        get 'states/:country_id', to: 'states#index', as: :states

        devise_for :users, controllers: {registrations: :registrations}

        resources :users, only: [] do
            collection do
                get 'dashboard'
                get 'orders'
                get 'reviews'
                get 'wishlist'
                get 'prescriptions'
            end
        end
    # end
end

Spree::Core::Engine.routes.draw do
    resources :orders do
        collection do
            get 'select_lens/:line_item_id', to: 'orders#select_lens', as: :select_lens
            get 'select_prescription/:line_item_id', to: 'orders#select_prescription', as: :select_prescription
            get 'select_options/:line_item_id', to: 'orders#select_options', as: :select_options
            get 'recommendations/:line_item_id', to: 'orders#recommendations', as: :recommendations
            patch 'add_recommendations/:line_item_id', to: 'orders#add_recommendations', as: :add_recommendations
        end
    end

    resources :products do
        member do
            get 'thumbnails/:color_id', to: 'products#thumbnails', as: :thumbnails
            get 'reviews', to: 'products#reviews', as: :reviews
        end
    end

    namespace :admin do
        resources :users, except: [:new, :create] do
            resources :prescriptions
        end

        resources :products do
            resources :frame_colors do
                collection do
                    post :update_positions
                end
            end
            member do
                get :limitations
            end
        end

        resources :frames
        resources :contact_lenses
        resources :lenses
        resources :lens_thicknesses do
            resources :lens_thickness_options do
                collection do
                    post :update_positions
                end
            end
        end
        resources :lens_protections do
            resources :lens_protection_options do
                collection do
                    post :update_positions
                end
            end
        end
        resources :basic_products

        resources :prescription_categories do
            collection do
                post :update_items_positions
            end
        end
        delete '/prescription_items/:id', to: 'prescription_items#destroy', as: :prescription_item
        resources :prescription_items do
            collection do
                post :update_values_positions
            end
        end
        delete '/prescription_values/:id', to: 'prescription_values#destroy', as: :prescription_value

        resources :brands do
            collection do
                post :update_positions
            end
        end

        resources :lens_types
        resources :prescription_lens_rules
        resources :menus, only: [:index, :edit, :update] do
            resources :menu_items do
                collection do
                    post :update_menu_items_positions
                end
            end
        end
        resources :page_contents, except: [:show, :new, :create]
    end
end
