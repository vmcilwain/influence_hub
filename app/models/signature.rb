class Signature < ApplicationRecord
  belongs_to :document, class_name: 'AppDocument', foreign_key: 'app_document_id'
  belongs_to :campaign
end
