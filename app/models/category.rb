class Category < ApplicationRecord
  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  default_scope { order(title: :asc) }

  has_and_belongs_to_many :articles

  after_update { self.articles.each(&:touch) }
end
