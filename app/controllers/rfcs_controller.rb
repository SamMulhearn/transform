class RfcsController < ApplicationController
	
	def new
		@rfc = Rfc.new(:status => 'New')
	end

end
