module ContactsHelper
  def cancel_contact_link(contact)
    link_to :Cancel,
            (contact.new_record? ? contact.organization : organization_contact_path(contact.organization, contact)),
            class: :secondary
  end

  def contact_name(contact)
    name = "#{contact.first_name} #{contact.last_name}"
    name += " #{contact.suffix}" if contact.suffix.present?
    name
  end
end
