# == Schema Information
#
# Table name: rfcs
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  priority        :integer
#  title           :string(255)
#  status          :text
#  objective       :text
#  risk            :text
#  mitigate_risks  :text
#  backup          :text
#  impact          :text
#  imp_plan        :text
#  pre_task        :text
#  post_task       :text
#  backout_plan    :text
#  imp_date        :date
#  downtime_start  :time
#  downtime_finish :time
#

require 'spec_helper'

describe Rfc do
  pending "add some examples to (or delete) #{__FILE__}"
end
