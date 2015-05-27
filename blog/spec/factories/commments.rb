# Creates a factory article to use in specs
FactoryGirl.define do
  factory :comment do |f|
    f.commenter "Jeffrey"
    f.body "This is a great article!"
  end

  # Invalid comment factory
  factory :invalid_comment, parent: :comment do |f|
    f.commenter nil
  end
end
