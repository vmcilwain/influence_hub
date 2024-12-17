require 'test_helper'

class ListTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :name
    should validate_presence_of :title
    should validate_presence_of :val

    should 'validate uniqueness of title scoped to name' do
      list = create(:list)
      bad_list = build(:list, name: list.name, title: list.title)

      assert_not bad_list.valid?
      assert bad_list.errors[:title]
    end

    should 'validate uniqueness of val scoped to title' do
      list = create(:list)
      bad_list = build(:list, name: list.name, title: list.title, val: list.val)

      assert_not bad_list.valid?
      assert bad_list.errors[:val]
    end
  end
end
