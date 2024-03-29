class JuniorRole < Rule

  def check role
    checklist = Role.all.reject { |rr| role.all_uppers.include?(rr) or role.all_childs.include?(rr) }
    checklist.each do |target|
      if is_junior target, role
        badge = Badge.new
        badge.role = role
        badge.score = 5
        badge.message = Message.find(3)
        badge.comment = " (Rolle: #{target.name})"
        badge.save
      end
    end
  end

  def is_junior role, junior
    return false if role == junior
    tasks = junior.all_tasks
    tasks.delete_if { |item| role.all_tasks.include? item }
    return 0 == tasks.length
  end
end
