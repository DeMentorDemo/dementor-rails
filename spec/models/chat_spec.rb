require 'rails_helper'

describe Chat, type: :model do

  it {is_expected.to validate_presence_of(:name)}
  it {should have_many(:messages).dependent(:destroy)}
  it {should have_and_belong_to_many :users}

end
