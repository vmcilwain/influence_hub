class Task < ApplicationRecord
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
  belongs_to :user
  belongs_to :campaign
  
  has_rich_text :details

  scope :not_started, -> { where(status: :not_started) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :complete, -> { where(status: :complete) }
  scope :abandoned, -> { where(status: :abandoned) }
  
  scope :deliverable, -> { where(kind: :deliverable) }
  scope :milestone, -> { where(kind: :milestone) }
  scope :approval, -> { where(kind: :approval) }
  scope :post, -> { where(kind: :post) }
  scope :blog, -> { where(kind: :blog) }

  validates :description, :due_on, :status, :kind, presence: true
end
