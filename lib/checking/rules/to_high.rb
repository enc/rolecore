class ToHigh < Rule

  def check role
    if role.hight >= 4
      badge = Badge.new
      badge.role = role
      badge.score = 2
      badge.message = Message.find 5
      badge.save
    end
  end
end
