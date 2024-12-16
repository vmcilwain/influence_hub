class Contact < ApplicationRecord
  belongs_to :organization

  validates :first_name, presence: true
  validates :email, uniqueness: { scope: :organization_id, case_insensitive: true }, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  before_validation :validate_email_or_phone

  private

  def validate_email_or_phone
    return unless email.blank? && phone.blank?

    errors.add(:base, 'Email or phone must be present')
    throw(:abort)
  end
end
