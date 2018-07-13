require 'rails_helper'

describe User, type: :model do

  it {is_expected.to validate_presence_of(:email)}
  it {is_expected.to validate_presence_of(:first_name)}
  it {is_expected.to validate_presence_of(:last_name)}
  it {should have_many(:messages)}
  it {should have_and_belong_to_many(:chats)}

end