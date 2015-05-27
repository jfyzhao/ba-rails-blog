# Creates a factory article to use in specs
FactoryGirl.define do
  factory :article do |f|
    f.title "Supreme Court Rules Supreme Court Rules"
    f.text "lorem ipsum dolor"
  end

  # Invalid article factory
  factory :invalid_article, parent: :article do |f|
    f.title nil
  end
end
