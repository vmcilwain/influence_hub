module OrganizationsHelper
  def cancel_organization_link(organization)
    link_to :Cancel,
            (organization.new_record? ? organizations_path : organization),
            class: :secondary
  end
end
