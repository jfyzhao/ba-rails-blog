# Creates a factory article to use in specs
FactoryGirl.define do
  factory :comment do
    commenter "Jeffrey"
    body "This is a great article!"
    article
    #association :article_id, factory: :article
  end

  # Invalid comment factory
  factory :invalid_comment, parent: :comment do
    commenter nil
  end
end
