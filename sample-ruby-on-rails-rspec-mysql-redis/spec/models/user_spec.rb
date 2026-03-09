require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:age) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_numericality_of(:age).only_integer.is_greater_than(0) }

  it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:age).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_index(:email).unique }

  it 'is invalid with a malformed email' do
    user = build(:user, email: 'not-an-email')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include('is invalid')
  end
end
