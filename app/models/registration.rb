# frozen_string_literal: true

# == Schema Information
#
# Table name: registrations
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  goodgymer_id :integer
#  session_id   :integer
#
# Indexes
#
#  index_registrations_on_goodgymer_id_and_session_id  (goodgymer_id,session_id) UNIQUE
#
class Registration < ActiveRecord::Base
  belongs_to :goodgymer
  belongs_to :session

  validates :goodgymer_id, :session_id, presence: true
  validates :goodgymer_id, uniqueness: { scope: :session_id }
end
