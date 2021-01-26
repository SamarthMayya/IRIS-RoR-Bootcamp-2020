# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # All users
    can :index, Article
    
    # Can read public articles
    can :show, Article, public: true

    # Can sign up
    can :new, User
    can :create, User

    # Additional permissions for logged in users
    if user.present?
      # Can read private articles provided that the number hasn't exceeded private_articles_remaining.
      can :show, Article

      # Can create articles
      can :new, Article
      can :create, Article

      # Can edit their own articles
      can :edit, Article, user_id: user.id
      can :update, Article, user_id: user.id

      # Can destroy their own articles
      can :destroy, Article, user_id: user.id

      # Can see list of users for now
      can :index, User 

      # Can see their own profile
      can :show, User, id: user.id 

      # Can edit their own profile
      can :edit, User, id: user.id
      can :update, User, id:user.id

      # Allow only admins to edit the Users table
      if user.admin
        # Admin Can destroy any user.
        can :destroy, User  
      end 
    end 

    # if user.admin?
      # Give provision to create, edit and delete users, only if the current user is an admin.
      # can :index, User 
      #can :new, User
      #can :create, User
      #can :edit, User
      #can :destroy, User 
    #end 
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
