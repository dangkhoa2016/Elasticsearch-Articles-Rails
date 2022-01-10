class Comment < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  default_scope { order(title: :asc) }

  belongs_to :article, touch: true
end
