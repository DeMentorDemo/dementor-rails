require 'rails_helper'

describe Message, type: :model do

  it {is_expected.to validate_presence_of(:text)}
  it {should belong_to :user}
  it {should belong_to :chat}

end
