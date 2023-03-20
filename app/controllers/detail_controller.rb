class DetailController < ApplicationController
    before_action :authenticate_user!
    respond_to :json
    def show
        user = current_user
        detail = user.detail
        if detail.nil?
            response = {
                first_name: detail&.first_name || "null",
                last_name: detail&.last_name || "null",
                age: detail&.age || "null",
                gender: detail&.gender || "null"
            }
        else
            response = {
                first_name: detail&.first_name || "null",
                last_name: detail&.last_name || "null",
                age: detail&.age || "null",
                gender: detail&.gender || "null",
                image_url: detail.image_url.attached? ? url_for(detail.image_url) : nil           
            }
        end
    
        
        
        render json: response, status: 200
    end
      

    def update
        user = current_user
        detail = user.detail 
        if detail.nil?
            detail = Detail.new(user_id: user.id)
        end
        if params[:image_url].present?
            detail.image_url&.attach(params[:image_url])        
        end

        if detail.update(detail_params)
            render json: detail, status: 200
          else
            render json: {
              error: "Unable to update details"
            }
          end
        rescue ActiveRecord::RecordNotFound =>error
            render json: error.message , status: :unauthorized
      end
      


    private
    def detail_params
        params.permit(:first_name, :last_name, :age, :gender, :image_url)
    end

  
end






