FactoryBot.define do
  factory :gif do
    title { "MyString" }
    source_url { "https://youtube.com" }
    user { nil }
    public { false }

    after(:build) do |source|
      image = File.open(Rails.root.join('spec', 'factories', 'images', 'lulu_wink.gif'))
      source.image.attach(io: image, filename: 'lulu_wink.gif')
    end
  end
end
