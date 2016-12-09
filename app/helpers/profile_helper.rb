
module ProfileHelper

  def my_profile
    current_user == @profile.user
  end

  def friends?
    Friendship.between(current_user, @profile.user).any?
  end

end
