# frozen_string_literal: true

require 'rails_helper'

describe 'Homepage' do
  before do
    driven_by :selenium_chrome_headless
  end

  it 'shows greeting' do
    visit root_url
    expect(page).to have_content 'Hello World'
  end
end
