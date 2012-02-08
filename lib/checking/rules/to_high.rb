class ToHigh < Rule

  def check role
    if role.hight >= 5
      badge = Badge.new
      badge.role = role
      badge.score = 10
      badge.message = Message.find 2
      badge.save
    end
  end
end
