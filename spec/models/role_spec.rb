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
  end

  it "returns all children, no matter how deep nested" do
    subrole = Factory.create(:role)
    subrole.name.should eq("Rolle7")
    role.add_subrole subrole  # 1 Kind

    srole2 = Factory(:role)  # 1 Kindeskind, 2. Kind
    srole2.name.should eq("Rolle9")
    role.childs.first.add_subrole srole2

    role.relations.count.should eq(1)
    role.all_childs.count.should eq(2)

    srole3 = Factory(:role) # 2. Kind, 3 Kinder gesammt
    srole3.name.should eq("Rolle10")
    role.add_subrole srole3
    role.relations.count.should eq(2)
    role.childs.count.should eq(2)
    role.childs.first.childs.count.should eq(1)

    role.all_childs[0].name.should eq("Rolle7")
    role.all_childs.size.should eq(3)
  end
end
