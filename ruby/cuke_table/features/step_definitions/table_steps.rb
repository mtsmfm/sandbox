Given(/^a table:$/) do |table|
  @table = table
end

Then(/^the table should match:$/) do |table|
  table.diff!(@table)
end
