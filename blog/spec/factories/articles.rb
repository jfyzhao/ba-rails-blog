# Creates a factory article to use in specs
FactoryGirl.define do
  factory :article do |f|
    f.title "Supreme Court Rules Supreme Court Rules"
    f.text "lorem ipsum dolor"
  end
end
