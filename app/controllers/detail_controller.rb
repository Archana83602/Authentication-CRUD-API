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
                image_url: detail.image.attached? ? url_for(detail.image) : nil           
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
        if detail.update(detail_params)
          render json: {
            status: { code: 200, message: 'User updated successfully', data: detail },
            image_url: detail.image.present? ? url_for(detail.image) : nil
            }
        else
          render json: {
            status: { code: 422, message: 'User could not be updated', errors: user.errors.full_messages }
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound => error
        render json: { error: error.message }, status: :unauthorized
      end
      


    private
    def detail_params
        info = params.permit(:first_name, :last_name, :age, :gender, :image)
        return info
    end

  
end






