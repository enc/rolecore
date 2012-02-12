class ManyMembers < Rule

  def check role
    if role.users.count >= 4
      badge = Badge.new
      badge.role = role
      badge.score = role.users.count - 3
      badge.message = Message.find 4
      badge.save
    end
  end
end
