class Rule

  def initialize
    Checker.register self
  end
  ###################################################################

  @@rules = Set.new
  # Registers calculator to be used with selected kinds of operations
  def self.register
    @@rules.add(self)
    Checker.register self
    self
  end

  # Returns all calculators applicable for kind of work
  # If passed nil, will return only general calculators
  def self.rules
    @@rules.to_a
  end

end
