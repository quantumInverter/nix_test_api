class Tag < ApplicationRecord
  before_save :downcase_name

  default_scope { order(questions_count: :desc) }

  validates :name, uniqueness: { case_sensitive: false }, length: { in: 2..60 }
  has_and_belongs_to_many :questions

  private

    def downcase_name
      self.name.downcase!
    end
end
