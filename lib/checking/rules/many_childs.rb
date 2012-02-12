class ManyChilds < Rule

  def check role
    if role.all_childs.count >= 9
      badge = Badge.new
      badge.role = role
      badge.score = role.all_childs.count - 7
      badge.message = Message.find 1
      badge.save
    end
  end
end
