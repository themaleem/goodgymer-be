# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id                 :bigint           not null, primary key
#  address            :string
#  created_by         :integer
#  date               :date
#  description        :text
#  name               :string
#  registration_limit :bigint
#  session_type       :integer
#  start_time         :time
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  area_id            :string
#  session_id         :string
#
# Indexes
#
#  index_sessions_on_created_by    (created_by)
#  index_sessions_on_session_id    (session_id) UNIQUE
#  index_sessions_on_session_type  (session_type)
#
class Session < ActiveRecord::Base
  enum :session_type, { community_mission: 0, social_visit: 1, group_run: 2 }.freeze

  has_many :pairings
  has_many :registrations, dependent: :destroy
  has_many :goodgymers, through: :registrations

  belongs_to :creator, class_name: 'Goodgymer', foreign_key: 'created_by'

  validates :date, :start_time, :address, :description, presence: true
  validates :name, :area_id, :session_type, :registration_limit, :created_by, presence: true

  before_create :generate_unique_session_id

  def can_register?(goodgymer)
    case session_type
    when 'community_mission'
      goodgymer.task_force?
    when 'social_visit'
      goodgymer.dbs_verified?
    # @note for group_run
    else
      true
    end
  end

  def registration_count
    registrations.count
  end

  private

  def generate_unique_session_id
    base_slug = "#{area_id}-#{SecureRandom.uuid}"

    self.session_id = base_slug
  end
end
