class ManyChilds < Rule

  def ckeck role
    if role.childs < 5
      badge = Badge.new
      badge.role = role
      bage.message = Message.find 1
      badge.save
    end
  end
end
