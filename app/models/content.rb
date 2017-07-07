class Content < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :category_id
end
