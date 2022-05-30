class ApplicationController < ActionController::Base

  
  def index

    render(:template=>"users/homepage.html.erb")
  end

  def show 
    @username = params.fetch(:user)
    @user_id = User.where(:username=>@username).at(0).id
    @list_of_photos=Photo.where(:owner_id=>@user_id)


    
  render(:template=>"users/show.html.erb")
  end

  def feed
    @user = User.where(:id=>session.fetch(:user_id)).at(0)
    @username = @user.username
    @list_of_photos=Photo.where(:owner_id=>@user.id).order({ :created_at => :desc })
    render(:template=>"users/feed.html.erb")
  end

  def index_users
    users = User.all
    @list_of_users = users.order({ :created_at => :desc })
    
    @follow_requests = FollowRequest.where(:sender_id=>session.fetch(:user_id))
    


    render(:template=>"users/index.html.erb")
  end
  before_action(:load_current_user)
  
  # Uncomment line 5 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

end
