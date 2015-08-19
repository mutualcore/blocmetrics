class API::EventsController < ApplicationController

	before_filter :set_access_control_headers

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
		headers['Access-Control-Allow-Headers'] = 'Content-Type'
	end

	skip_before_action :verify_authenticity_token

	def create
		registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
		if registered_application.nil?
			render json: "Unregistered app", status: :unprocessable_entity
		else
			@event = registered_application.events.build(event_params)
			if @event.save
				render json: @event, status: :created
			else
				render @event.errors, status: :unprocessable_entity
			end
		end
	end

	private
		def event_params
			params.permit(:event_name)
		end
end