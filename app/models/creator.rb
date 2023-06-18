class Creator < ApplicationRecord
  has_many :models, dependent: :nullify
  has_many :links, as: :linkable, dependent: :destroy
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  default_scope { order(:name) }

  before_validation :slugify_name, if: :name_changed?

  private

  def slugify_name
    self.slug = name.parameterize
  end
end
