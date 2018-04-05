# frozen_string_literal: true

# == Schema Information
#
# Table name: developers
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null

FactoryBot.define do
  factory :developer do
    email { Faker::Internet.email }
  end
end