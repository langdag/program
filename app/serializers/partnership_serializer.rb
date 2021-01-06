class PartnershipSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :files
    
    def files
      if object.files.attached?
        object.files.map do |file|
          {
            id: file.id,
            name: file.name,
            path: file.url
          }
        end
      end
    end
end