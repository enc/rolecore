require 'spec_helper'

describe Role do
  let(:role) { Factory(:role) }

  it "displays a role name" do
    role.name.should be_present
  end

  it "will add role as child" do
    role.add_subrole(Factory.create(:role))
    role.childs.count.should eq(1)
  end

  it "adds tasks" do
    role.add_task(Factory(:task))
    role.tasks.count.should eq(1)
  end

  it "returns tasks of subroles" do
    subrole = Factory(:role)
    role.add_subrole subrole
    subrole.add_task Factory(:task)
    role.all_tasks.count.should eq(1)
    role.add_task Factory(:task)
    role.all_tasks.count.should eq(2)
    role.all_tasks.count.should eq(role.task_count)
  end

  it "returns all children, no matter how deep nested" do
    subrole = Factory.create(:role)
    role.add_subrole subrole  # 1 Kind

    srole2 = Factory(:role)  # 1 Kindeskind, 2. Kind
    role.childs.first.add_subrole srole2

    role.relations.count.should eq(1)
    role.all_childs.count.should eq(2)

    srole3 = Factory(:role) # 2. Kind, 3 Kinder gesammt
    role.add_subrole srole3
    role.all_childs.size.should eq(3)
  end
end
