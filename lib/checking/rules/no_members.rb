class NoMembers < Rule

  def check role
    if role.users.count == 0 and role.uppers.count == 0
      badge = Badge.new
      badge.role = role
      badge.score = 4
      badge.message = Message.find 6
      badge.save
    end
  end
end
