require 'rails_helper'

describe 'トップページ' do
  before do
    visit root_path
  end

  it 'kairosと表示' do
    expect(page).to have_content 'kairos'
  end

  context 'スケッチの作成' do
    before do
      fill_in 'sketch_name', with: 'マイスケッチ'
      find('input[type=submit]').click
    end

    it '新しいスケッチを作成' do
      expect(Sketch.count).to be 1
      expect(Sketch.find_by_name('マイスケッチ')).not_to be nil
    end
    it 'スケッチ画面に移動' do
      expect(current_path).to eq '/sketches/1'
    end
  end
end
