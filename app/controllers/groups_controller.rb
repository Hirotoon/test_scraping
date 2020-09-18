class GroupsController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :edit, :destroy]

	def index
		@groups = Group.page(params[:page]).reverse_order
	end

	def show
		@group = Group.find(params[:id])
	end

	def new
		@group = Group.new
	end

	def edit
		@group = Group.find(params[:id])
	end

	def create
		@group=Group.new(group_params)
	    if @group.save
	    	flash[:notice] = "Registered group information."
      		@group.connect_volunteers(params[:group][:name], @group.id)
	    	redirect_to groups_path
	    else
	    	render :new
	    end
	end

	def update
		@group = Group.find(params[:id])
		group_old_name = @group.name
		if @group.update(group_params)
			if group_old_name != @group.name
				@group.disconnect_volunteers(@group.volunteers)
				@group.connect_volunteers(params[:group][:name], @group.id)
			end
			flash[:notice] = "Updated Group information."
			redirect_to group_path(@group.id)
		else
			render :edit
		end
	end

	def destroy
		group = Group.find(params[:id])
		group.disconnect_volunteers(group.volunteers)
		group.destroy
		redirect_to groups_path
	end

	def show_volunteers
		@group = Group.find(params[:id])
		@volunteers = @group.volunteers
	end

	private

	def group_params
		params.require(:group).permit(:name,:active_area,:address,:mail,:phone_number,:description,:image)
	end

end
