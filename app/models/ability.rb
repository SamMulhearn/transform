class Ability
  include CanCan::Ability
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    #user ||= User.new # guest user (not logged in)

    alias_action :cs, :to => :read
    #alias_action :edit, :save, :to => :update
    #abilityalias_action :new, :to => :create
    
    #All users, signed in or not
    
    if user == nil #guest user (not logged in)
      can :read, Rfc
      can :create, User
      can :read, User
    else
      #All signed in users
      can [:create,:read], Rfc
      can :update, Rfc, :user_id => user.id #Update/Edit Own RFCs   
      can :update, Approval, :role_id => user.role_ids
      can :index, Approval
      can :create, Comment
      can :read, User
      if user.roles.include?(Role.find_by_name("Change Management")) then
        can :manage, [Rfc, User]
        can :manage, Role, :approvalgroup => true
        can :manage, User
        can :manage, Approval
      end 
      if user.roles.include?(Role.find_by_name("Administrator")) then
        can :manage, :all
      end
    end

  end
end


      
      #   else
      #     can :read, :all
      #   end
      #
      # The first argument to `can` is the action you are giving the user permission to do.
      # If you pass :manage it will apply to every action. Other common actions here are
      # :read, :create, :update and :destroy.
      #
      # The second argument is the resource the user can perform the action on. If you pass
      # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
      #
      # The third argument is an optional hash of conditions to further filter the objects.
      # For example, here the user can only update published articles.
      #
      #   can :update, Article, :published => true
      #
      # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
