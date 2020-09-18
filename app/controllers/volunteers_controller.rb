class VolunteersController < ApplicationController

      def index
          @volunteers = Volunteer.where.not(group_id: nil).page(params[:page]).reverse_order
      end

      def show
          @volunteer = Volunteer.find(params[:id])
      end

end
