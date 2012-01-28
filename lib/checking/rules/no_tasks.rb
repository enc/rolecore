class NoTasks < Rule

  def check role
    if role.task_count == 0
      badge = Badge.new
      badge.role = role
      badge.score = 10
      badge.message = Message.find 2
      badge.save
    end
  end
end
