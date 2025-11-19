class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # invitado

    # ========== ADMIN: control total ==========
    if user.admin?
      can :manage, :all
      return
    end

    # ========== INVITADO (no logueado) ==========
    can :read, Challenge
    can :read, User
    can :read, Badge
    can :read, Tag

    # No más permisos si no está logeado
    return unless user.persisted?

    # ========== LOGUEADO (standard o creator) ==========
    # Lectura general
    can :read, Challenge
    can :read, User
    can :read, Badge
    can :read, Tag

    # 👉 Cada usuario puede ver y editar SU propio perfil
    can [:read, :update], User, id: user.id

    # 👉 SOLO admin maneja Participations
    # (no damos permisos aquí)

    # 👉 Progress entries: cada usuario maneja los suyos
    can :create, ProgressEntry
    can [:update, :destroy], ProgressEntry, participation: { user_id: user.id }

    # Notificaciones propias
    can :read, Notification, user_id: user.id

    # UserBadges propios
    can :read, UserBadge, user_id: user.id

    # ========== CREATOR ==========
    if user.creator?
      # Challenges que él creó
      can :create, Challenge
      can [:update, :destroy], Challenge, owner_id: user.id

      # Badges & Tags (CRUD completo)
      can :create, Badge
      can [:update, :destroy], Badge

      can :create, Tag
      can [:update, :destroy], Tag

      # 👉 Creator puede gestionar ProgressEntries de TODA su challenge
      can [:create, :update, :destroy], ProgressEntry do |entry|
        entry.participation.challenge.owner_id == user.id
      end
    end

    # STANDARD:
    # No tiene permisos adicionales
  end
end