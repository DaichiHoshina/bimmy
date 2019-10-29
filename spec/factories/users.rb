# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'testtest@test.jp' }
    password { 'test1234' }
  end
end
