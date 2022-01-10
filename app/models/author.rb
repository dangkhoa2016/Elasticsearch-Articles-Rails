class Author < ApplicationRecord
  has_many :authorships
  has_many :articles, through: :authorships
  default_scope { order(created_at: :desc) }
  
  def full_name
    [first_name, last_name].join(' ')
  end

  after_update { self.authorships.each(&:touch) }
end
