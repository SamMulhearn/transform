class Ability
  include CanCan::Ability
    def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    #user ||= User.new # guest user (not logged in)
    
    if user == nil #guest user (not logged in)
      can :read, Rfc
    else
      Rails.logger.error "Some debugging info I want to see in my development log."

      #everyone
      clear_aliased_actions
      #alias_action :index, :show, :to => :read
      #can :read, :rfc
      #can :index, :rfcs

      # if 
      #   can :update, :rfcs, :user_id => current_user.id
      # else
      #   can :create, :rfcs
      # end

      # if chgmgr
      #   can [:update], :rfcs
      # end
      
      #Everyone
      alias_action :index, :show, :to => :read
      alias_action :edit, :to => :update
      alias_action :new, :save, :to => :create

      can :read, Rfc
      can :create, Rfc
      can :update, Rfc, :user_id => user.id #Update/Edit Own RFCs

      if user.roles.include?(Role.find_by_name("Change Manager"))
        can :update, Rfc
      end

      #Is Administrator
      if user.roles.include?(Role.find_by_name("Administrator"))
         can :manage, :all
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
    end
  end
end
