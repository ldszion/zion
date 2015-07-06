require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  setup do
    @person = people(:one)
    @person.ward = Ward.first
    @person.phones << Phone.new(number: "(61) 8125-7757")
  end

  test "person should be valid" do
    assert @person.valid?, why_is_not_valid(@person)
  end

  test "person without name should not be valid" do
    @person.name = ""
    assert_not @person.valid?
  end

  test "person without last name sould not be valid" do
    @person.last_name = "   "
    assert_not @person.valid?, "person is not valid because"
  end

  test "person without ward should not be valid" do
    @person.ward = nil
    assert_not @person.valid?, why_is_not_valid(@person)
  end

  test "person without phones should not be valid" do
    @person.phones.delete_all
    assert_not @person.valid?, "person is not valid because it should have phones"
  end

  # Returns a string explaining why the record is not valid
  def why_is_not_valid(record)
    "person is not valid because of: #{record.errors.full_messages.inspect}"
  end

end
