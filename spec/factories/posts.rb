# frozen_string_literal: true

FactoryBot.define do
  factory :posts do
    title { '松茸ごはん' }
    store { '佐藤食堂' }
    description { '松茸の風味がとても美味しかったです。' }
    association :user
    association :map
  end
end
