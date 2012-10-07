# == Schema Information
#
# Table name: rfcs
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  priority        :integer
#  description     :string(255)
#  risk            :text
#  mitigate_risks  :text
#  backup          :text
#  impact          :text
#  imp_plan        :text
#  pre_task        :text
#  post_task       :text
#  backout_plan    :text
#  start           :datetime
#  finish          :datetime
#  downtime_start  :datetime
#  downtime_finish :datetime
#

require 'spec_helper'

describe Rfc do
  pending "add some examples to (or delete) #{__FILE__}"
end
