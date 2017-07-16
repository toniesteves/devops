require 'api_version_constraint'

Rails.application.routes.draw do

  devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: :api }, path: "/" do

    namespace :v1, path: "/", constraints: ApiVersionContraint.new(version: 1, default: true) do



    end

  end

end
