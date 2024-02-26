# frozen_string_literal: true

# frozen string literal: true

# Controller for user profile pages
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update]
  before_action :correct_user, only: %i[update destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts # Adjust the query as needed
    @approved_followers = @user.follower_relationships.includes(:follower).where(status: 'approved')
  end

  def update
    if @user.update(user_params)
      process_and_attach_image(params[:user][:profile_picture], 'profile_picture', '300x300>') if params[:user][:profile_picture].present?
      process_and_attach_image(params[:user][:banner_image], 'banner_image', '1200x300>') if params[:user][:banner_image].present?
  
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user && @user.destroy
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      redirect_to root_path, notice: 'Your account and all associated data have been successfully deleted.'
    else
      redirect_to @user, alert: 'There was a problem deleting your account.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :profile_picture, :banner_image)
  end

  # Ensures that users can only update their own profiles
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path, alert: 'Unauthorized action.') unless @user == current_user
  end

  # Processes the uploaded image to a standard size
  def process_and_attach_image(uploaded_image, image_type, dimensions)
    image = MiniMagick::Image.new(uploaded_image.path)
    image.resize dimensions # This resizes while maintaining aspect ratio
  
    # Save the processed image to a temporary file
    temp_file = Tempfile.new(["#{image_type}", File.extname(uploaded_image.original_filename)])
    image.write(temp_file.path)
  
    # Create an attachable object
    attachable = {
      io: File.open(temp_file.path),
      filename: uploaded_image.original_filename,
      content_type: uploaded_image.content_type
    }
  
    @user.send("#{image_type}").attach(attachable)
  
    # Ensure the temporary file is deleted after processing
    temp_file.unlink
  end
end
