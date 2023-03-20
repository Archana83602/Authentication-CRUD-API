class DetailSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :first_name,:last_name,:age,:gender, :image_url
  def image_url
    if object.image_url.attached?
      {
        url: rails_blob_url(object.image_url)
      }
    end
  end
end
