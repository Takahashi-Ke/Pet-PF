require 'rails_helper'

RSpec.describe '', type: :system do
  before do
    @pet = create(:pet)
  end
  it 'ログイン画面が表示されること' do
    visit '/sessions/new'
  end
end