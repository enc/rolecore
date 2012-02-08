class Checker


  def self.register rule
    @@rules ||= Array.new
    @@rules.push rule
  end

  def self.check role
    role.badges.delete_all
    @@rules.each do |rule|
      rule.new.check role
    end
  end

  def self.rules
    @@rules
  end

  def self.check_all
    Role.all.each do |role|
      self.check role
    end
  end

  # register all rules here manually...
  [
    ManyChilds,
    NoTasks,
    JuniorRole,
    ToHigh,
    ManyMembers
  ].each(&:register)
end
