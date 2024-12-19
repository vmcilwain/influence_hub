class Signature < ApplicationRecord
  belongs_to :document, class_name: 'AppDocument', foreign_key: 'app_document_id'
  belongs_to :campaign

  validates :signee_email, presence: true

  before_validation :generate_external_id, on: :create
  before_validation :generate_security_code, on: :create

  enum :status, {
    pending: 0,
    signed: 1
  }

  private
  
  def generate_external_id
    return if external_id.present?
    
    loop do
      self.external_id = SecureRandom.uuid
      break unless Signature.exists?(external_id: external_id)
    end
  end

  def generate_security_code
    return if security_code.present?
    
    loop do
      self.security_code = SecureRandom.hex(3)
      break unless Signature.exists?(security_code: security_code)
    end
  end
end
