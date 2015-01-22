class Stance < ActiveRecord::Base
  belongs_to :user
  belongs_to :position
  has_many :upvotes
  has_many :politician_stances
  has_many :politicians, through: politician_stances
end