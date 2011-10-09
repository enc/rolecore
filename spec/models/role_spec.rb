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
    subrole = Factory(:role)
    role.add_subrole subrole
    subrole.add_subrole Factory(:role)
    role.relations.count.should eq(1)
    role.all_childs.count.should eq(2)
    role.add_subrole Factory(:role)
    role.relations.count.should eq(2)
    role.all_childs.count.should eq(3)
  end
end
