require 'spec_helper'

RSpec.describe do
  specify do
    begin
      table = Cucumber::MultilineArgument::DataTable.new([
        {a: 1, b: 2, c: 3},
        {a: 2, b: 3, c: 4}
      ])

      table.diff!([
        {a: 1, b: 3}
      ])
    end
  end
end
