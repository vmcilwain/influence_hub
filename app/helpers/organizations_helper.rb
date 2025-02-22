module OrganizationsHelper
  def cancel_link(organization)
    link_to :Cancel,
            (organization.new_record? ? organizations_path : organization),
            class: :secondary
  end
end
