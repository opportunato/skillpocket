require 'csv'

namespace :populate do
  desc "Add preapproved handles"
  task :handles => :environment do
    inserts = []

    CSV.foreach("#{Rails.root}/db/fixtures/preapproved.csv", headers: true, col_sep: ",") do |row|
      inserts.push "('#{row[0]}', #{row[13]})"
    end

    sql = "INSERT INTO preapproved_handles (name, social_authority) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql
  end
 end