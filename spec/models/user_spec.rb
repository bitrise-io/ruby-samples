require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:age) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_numericality_of(:age).only_integer.is_greater_than(0) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid with a malformed email' do
      user.email = 'not-an-email'
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'is invalid with a negative age' do
      user.age = -1
      expect(user).not_to be_valid
    end

    it 'is invalid with age zero' do
      user.age = 0
      expect(user).not_to be_valid
    end
  end

  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:age).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_index(:email).unique(true) }
  end
end
