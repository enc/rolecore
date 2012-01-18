class Checker


  def self.register rule
    @@rules ||= Array.new
    @@rules.push rule
  end

  def self.check role
    @@rules.each do |rule|
      rule.new.check role
    end
  end

  # register all rules here manually...
  [
    ManyChilds
  ].each(&:register)
end
