module ContactsHelper
  def cancel_contact_link(contact)
    link_to :Cancel,
            (contact.new_record? ? contact.organization : organization_contact_path(contact.organization, contact)),
            class: :secondary
  end
end
