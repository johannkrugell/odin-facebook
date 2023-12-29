# frozen string literal: true

# Controller for user profile pages
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]
  before_action :correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts  # Adjust the query as needed
    @approved_followers  = @user.follower_relationships.includes(:follower).where(status: 'approved')
  end

  def update
    if @user.update(user_params)
      if params[:user][:banner_image].present?
        processed_image_file = process_image(params[:user][:banner_image])
      
        # Create an attachable object
        attachable = {
          io: File.open(processed_image_file.path),
          filename: "banner_image.png",
          content_type: "image/png"
        }
        @user.banner_image.attach(attachable)
      end
        redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :show
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:profile_picture, :banner_image, :username)
  end

  # Ensures that users can only update their own profiles
  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

  # Processes the uploaded image to a standard size
  def process_image(uploaded_image)
    image = MiniMagick::Image.new(uploaded_image.path)
    image.resize "800x600"
    image.crop "800x600+0+0"

    # Save the processed image to a temporary file
    temp_file = Tempfile.new(["processed_image", ".png"])
    image.write(temp_file.path)
    temp_file
  end
end
