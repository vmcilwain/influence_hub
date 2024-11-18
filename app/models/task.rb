class Task < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  
  has_rich_text :details

  validates :description, :due_on, :status, :kind, presence: true
  
  enum :status, {
    not_started: 0,
    in_progress: 1,
    complete: 2,
    abandoned: 3
  }

  enum :kind, {
    deliverable: 0,
    milestone: 1,
    approval: 2,
    post: 3,
    blog: 4
  }
end
