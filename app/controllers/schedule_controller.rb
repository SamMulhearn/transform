class ScheduleController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { 
        if (params[:start]).present? and (params[:end]).present? then
          @rfcs = Rfc.scheduled_between(Time.at(params['start'].to_i),Time.at(params['end'].to_i)).where("rfcs.imp_date IS NOT NULL")          
        else
          @rfcs = Rfc.where("rfcs.imp_date IS NOT NULL")
        end
      }
    end
  end
end
