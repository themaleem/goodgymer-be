# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id                 :bigint           not null, primary key
#  created_by         :integer
#  name               :string
#  registration_limit :bigint
#  session_type       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  area_id            :string
#  session_id         :string
#
# Indexes
#
#  index_sessions_on_created_by    (created_by)
#  index_sessions_on_session_type  (session_type)
#
class Session < ActiveRecord::Base
  enum :session_type, { community_mission: 0, social_visit: 1, group_run: 2 }.freeze

  has_many :pairings
  has_many :registrations, dependent: :destroy
  has_many :goodgymers, through: :registrations

  belongs_to :creator, class_name: 'Goodgymer', foreign_key: 'created_by'

  validates :name, presence: true
  validates :area_id, presence: true
  validates :session_type, presence: true
  validates :registration_limit, presence: true

  def can_register?(goodgymer)
    case session_type
    when 'community_mission'
      goodgymer.task_force?
    when 'social_visit'
      goodgymer.dbs_verified?
    # else 'group_run'
    #   true
    # @note for group_run
    else
      true
    end
  end
end
