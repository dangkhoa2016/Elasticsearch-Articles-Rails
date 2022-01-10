class Comment < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  default_scope { order(created_at: :desc) }

  belongs_to :article, touch: true
end
