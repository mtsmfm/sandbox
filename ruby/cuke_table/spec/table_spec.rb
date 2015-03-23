require 'spec_helper'

RSpec.describe do
  specify do
    begin
      table = Cucumber::Ast::Table.new([
        {a: 1, b: 2, c: 3},
        {a: 2, b: 3, c: 4}
      ])

      table.diff!([
        {a: 1, b: 3}
      ])
    rescue
      table = $!.table
      require 'cucumber/formatter/pretty'

      formatter = Cucumber::Formatter::Pretty.new(nil, STDOUT, {})
      visitor = Cucumber::Ast::TreeWalker.new(nil, [formatter])
      visitor.visit_multiline_arg(table)
      table.accept(visitor)
    end
  end
end
