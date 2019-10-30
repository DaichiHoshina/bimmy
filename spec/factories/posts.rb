# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { '松茸ごはん' }
    store { '佐藤食堂' }
    description { '松茸の風味がとても美味しかったです。' }
    image { File.open('spec/factories/images/test.jpg') }
    rate { '5' }
    association :user
  end
end
