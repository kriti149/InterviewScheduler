class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users=User.all
	end

	def show
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.create(user_params)
		if @user.save
			redirect_to users_path, notice: "User successfully created!"
		else
			render :new
		end
	end

	def update
		if @user.update(user_params)
			redirect_to users_path, notice: "User successfully edited!"
		else
			render :edit
		redirect_to users_path
		end
	end

	def destroy
		@user.destroy
		redirect_to users_path, notice: "User deleted successfully!"
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :mobile, :address, :participation)
	end

end
