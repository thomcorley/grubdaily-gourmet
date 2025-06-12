require 'rails_helper'

RSpec.describe "digested_reads/new", type: :view do
  before(:each) do
    assign(:digested_read, DigestedRead.new())
  end

  it "renders new digested_read form" do
    render

    assert_select "form[action=?][method=?]", digested_reads_path, "post" do
    end
  end
end
