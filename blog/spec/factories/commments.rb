# Creates a factory article to use in specs
FactoryGirl.define do
  factory :comment do |f|
    f.commenter "Jeffrey"
    f.body "This is a great article!"
  end
end
