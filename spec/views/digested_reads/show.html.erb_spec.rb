require 'rails_helper'

RSpec.describe "digested_reads/show", type: :view do
  before(:each) do
    @digested_read = assign(:digested_read, FactoryBot.create(:digested_read))
  end

  it "renders attributes in <p>"
end
