# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  due_date    :date
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (owner_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  validates :participating_users, presence: true

  validates :name, :description, presence: true
  validates :name, uniqueness: {
    case_insensitive: false
  }
  validate :due_date_validity

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today

    error.add :due_date, I18n.t('task.error.invalid due_date')
  end
end
