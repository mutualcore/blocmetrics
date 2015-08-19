class RegisteredApplicationsController < ApplicationController
	def index
		@registered_applications = RegisteredApplication.all
	end

	def show
		@registered_application = RegisteredApplication.find(params[:id])
		@events = @registered_application.events
	end

	def new
		@registered_application = RegisteredApplication.new
	end

	def edit
		@registered_application = RegisteredApplication.find(params[:id])
	end

	def create
		@registered_application = current_user.registered_applications.build(registered_application_params)
		
		if @registered_application.save
			redirect_to @registered_application
		else
			flash[:error] = "Error saving website"
		end
	end

	def update
		@registered_application = RegisteredApplication.find(params[:id])

		if @registered_application.update_attributes(registered_application_params)
			flash[:notice] = "Application was updated"
			redirect_to registered_applications_path
		else
			flash[:error] = "Error updating application"
			render :edit
		end
	end

	def destroy
		@registered_application = RegisteredApplication.find(params[:id])

		if @registered_application.destroy
			flash[:notice] = "Application deleted"
			redirect_to @registered_application
		else
			flash[:error] = "Error deleting application"
			redirect_to @registered_application
		end
	end

	private

	def registered_application_params
		params.require(:registered_application).permit(:name, :url)
	end
end
