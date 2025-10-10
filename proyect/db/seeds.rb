# db/seeds.rb

puts "Reseteando datos..."
[Notification, ProgressEntry, UserBadge, Participation, ChallengeTag, Challenge, Badge, Tag, User].each(&:delete_all)

ApplicationRecord.transaction do
  # --- Users ---
  puts "Users..."
  admin   = User.create!(name: "Admin",   email: "admin@example.com",   password: "secret123", role: "admin",   username: "admin")
  pedro   = User.create!(name: "Pedro",   email: "pedro@example.com",   password: "secret123", role: "creator", username: "pedro")
  vicente = User.create!(name: "Vicente", email: "vicente@example.com", password: "secret123", role: "creator", username: "vicente")
  juan    = User.create!(name: "Juan",    email: "juan@example.com",    password: "secret123", role: "standard", username: "juan")
  luis    = User.create!(name: "Luis",    email: "luis@example.com",    password: "secret123", role: "standard", username: "luis")

  # --- Tags & Badges ---
  cardio  = Tag.create!(name: "cardio")
  fuerza  = Tag.create!(name: "fuerza")
  habitos = Tag.create!(name: "habitos")
  agua    = Tag.create!(name: "agua")
  mind    = Tag.create!(name: "mindfulness")

  primer_paso = Badge.create!(code: "FIRST_STEP",    name: "Primer Paso", description: "Ingresó a su primer desafío")
  consistente = Badge.create!(code: "CONSISTENT_7",  name: "Consistente", description: "Completó 7 días seguidos")
  top1        = Badge.create!(code: "LEADERBOARD_1", name: "Top 1",       description: "Lideró el ranking del desafío")

  # --- Challenges ---
  hoy = Date.today
  reto_pasos = Challenge.create!(
    owner: pedro,
    name: "Reto 10k Pasos",
    description: "Caminar 10.000 pasos diarios durante 14 días.",
    category: "salud",
    start_date: hoy - 3,
    end_date:   (hoy - 3) + 14,
    frequency: "daily",
    points_per_entry: 1,
    max_entries_per_period: 1,
    is_approval_required: false,
    status: "active"
  )
  reto_fuerza = Challenge.create!(
    owner: vicente,
    name: "Fuerza Inicial",
    description: "Sentadillas, flexiones y plancha.",
    category: "fuerza",
    start_date: hoy,
    end_date:   hoy + 14,
    frequency: "daily",
    points_per_entry: 1,
    max_entries_per_period: 1,
    is_approval_required: false,
    status: "active"
  )
  reto_agua = Challenge.create!(
    owner: pedro,
    name: "Agua 2L por Día",
    description: "Beber 2L por día durante una semana.",
    category: "habitos",
    start_date: hoy + 1,
    end_date:   (hoy + 1) + 7,
    frequency: "daily",
    points_per_entry: 1,
    max_entries_per_period: 1,
    is_approval_required: false,
    status: "draft"
  )
  reto_mind = Challenge.create!(
    owner: vicente,
    name: "7 Días Mindfulness",
    description: "Práctica diaria de 10 minutos.",
    category: "mindfulness",
    start_date: hoy - 7,
    end_date:   hoy - 1,
    frequency: "daily",
    points_per_entry: 1,
    max_entries_per_period: 1,
    is_approval_required: false,
    status: "finished"
  )

  # --- Tagging ---
  puts "Etiquetando..."
  [
    [reto_pasos, [cardio, habitos]],
    [reto_fuerza, [fuerza]],
    [reto_agua, [agua, habitos]],
    [reto_mind, [mind, habitos]]
  ].each do |challenge, tags|
    tags.each { |t| ChallengeTag.create!(challenge:, tag: t) }
  end

  # --- Participations ---
  puts "Participaciones..."
  p1 = Participation.create!(user: juan,    challenge: reto_pasos,  role: "participant", state: "active",  total_points: 20,  joined_at: Time.current - 3.days)
  p2 = Participation.create!(user: luis,    challenge: reto_pasos,  role: "participant", state: "active",  total_points: 30,  joined_at: Time.current - 2.days)
  p3 = Participation.create!(user: pedro,   challenge: reto_pasos,  role: "creator",     state: "active",  total_points: 40,  joined_at: Time.current - 3.days)

  p4 = Participation.create!(user: juan,    challenge: reto_fuerza, role: "participant", state: "active",  total_points: 10,  joined_at: Time.current)
  p5 = Participation.create!(user: luis,    challenge: reto_fuerza, role: "participant", state: "pending", total_points: 0,   joined_at: Time.current)
  p6 = Participation.create!(user: vicente, challenge: reto_fuerza, role: "creator",     state: "active",  total_points: 15,  joined_at: Time.current)

  p7 = Participation.create!(user: juan,    challenge: reto_agua,   role: "participant", state: "pending", total_points: 0,   joined_at: Time.current)
  p8 = Participation.create!(user: luis,    challenge: reto_agua,   role: "participant", state: "pending", total_points: 0,   joined_at: Time.current)

  p9  = Participation.create!(user: juan,    challenge: reto_mind,   role: "participant", state: "active", total_points: 70, joined_at: Time.current - 7.days, left_at: Time.current - 1.day)
  p10 = Participation.create!(user: luis,    challenge: reto_mind,   role: "participant", state: "active", total_points: 60, joined_at: Time.current - 7.days, left_at: Time.current - 1.day)
  p11 = Participation.create!(user: vicente, challenge: reto_mind,   role: "creator",     state: "active", total_points: 95, joined_at: Time.current - 7.days, left_at: Time.current - 1.day)

  # --- Progress entries ---
  ProgressEntry.create!(participation: p1, logged_on: hoy - 2, quantity: 45, points_awarded: 1, note: "Caminata")
  ProgressEntry.create!(participation: p2, logged_on: hoy - 1, quantity: 60, points_awarded: 1, note: "Caminata")
  ProgressEntry.create!(participation: p6, logged_on: hoy,     quantity: 10, points_awarded: 1, note: "Flexiones")

  # --- Badges ---
  UserBadge.create!(user: juan,    badge: primer_paso, earned_at: Time.current - 5.days)
  UserBadge.create!(user: luis,    badge: primer_paso, earned_at: Time.current - 5.days)
  UserBadge.create!(user: pedro,   badge: primer_paso, earned_at: Time.current - 3.days)
  UserBadge.create!(user: vicente, badge: primer_paso, earned_at: Time.current - 3.days)
  UserBadge.create!(user: juan,    badge: consistente, earned_at: Time.current - 1.day)
  UserBadge.create!(user: vicente, badge: top1,        earned_at: Time.current - 1.day)

  # --- Notifications ---
  Notification.create!(user: juan,    title: "Bienvenido", body: "Te uniste a FitChallenge")
  Notification.create!(user: vicente, title: "Fin de desafío", body: "7 Días Mindfulness finalizó", notifiable: reto_mind)
end

puts "✅ Seed listo"
