class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new
    can :manage, :all
  end

end
