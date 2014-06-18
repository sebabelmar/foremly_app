require 'spec_helper'

describe Post do
  context "#associations" do
    it { should belong_to :user }
    it { should have_many :comments }
  end
end
