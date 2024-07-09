# frozen_string_literal: true

# == Schema Information
#
# Table name: goodgymers
#
#  id         :bigint           not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  area_id    :string
#  user_id    :integer
#
class Goodgymer < ActiveRecord::Base
  enum :role, { task_force: 0, regular: 1 }.freeze, default: :normal

  belongs_to :user

  has_many :pairings
  has_many :registrations
  has_many :sessions, through: :registrations

  delegate :email, :name, :first_name, :last_name, :unconfirmed_email, to: :user, allow_nil: true

  validates :role, presence: true
  validates :area_id, presence: true

  def dbs_verified?
    # @todo some dbs checking logic
  end
end
