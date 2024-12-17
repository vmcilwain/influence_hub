require "test_helper"

class ListItemTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :name
    should validate_presence_of :val

    should 'validate uniqueness of name scoped to list' do
      list_item = create(:list_item)
      bad_list_item = build(:list_item, list_id: list_item.list_id, name: list_item.name)

      assert_not bad_list_item.valid?
      assert bad_list_item.errors[:name]
    end

    should 'validate uniqueness of val scoped to name' do
      list_item = create(:list_item)
      bad_list_item = build(:list_item, list_id: list_item.list_id, name: list_item.name, name: list_item.name, val: list_item.val)

      assert_not bad_list_item.valid?
      assert bad_list_item.errors[:val]
    end
  end

  context 'associations' do
    should belong_to :list
  end
end
