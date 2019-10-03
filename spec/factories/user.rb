# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@exmple.com' }
    password { '' }
  end
end
