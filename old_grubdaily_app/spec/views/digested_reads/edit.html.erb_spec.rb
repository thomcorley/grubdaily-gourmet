require 'rails_helper'

RSpec.describe "digested_reads/edit", type: :view do
  before(:each) do
    @digested_read = assign(:digested_read, DigestedRead.create!())
  end

  it "renders the edit digested_read form"
end
