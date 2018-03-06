class Club < ApplicationRecord
  has_one :team
  require 'csv'
  def self.update_clubs
   clubs = ["Beach Cricket",
    "Beach Flag Football",
    "Beach Football - Men's",
    "Beach Football - Women's",
    "Beach Rugby - Men's (7's)",
    "Beach Rugby - Women's (7's)",
    "Beach Volleyball - Mixed",
    "Cheerleading",
    "Dance",
    "Football - Men's (11 a Side)",
    "Hockey - Mixed",
    "Lacrosse - Mixed (Social)",
    "Netball",
    "Pole Dancing",
    "Social Tourist - No sport participation included",
    "Swimming",
    "Tennis - Mixed"]


    clubs.each do |club|
      count = 0
      csv_table = CSV.table('output.csv')

      csv_table.delete_if do |row|
        row[4] != club
      end

      csv_table.each do |person|
        count += 1 if person[6] == '£PAID '
      end

      team = where(name: club).first_or_create do |team|
        team.name = club
        team.amount = csv_table.count
        team.paid = count
      end

      team.update(amount: csv_table.count) if team.amount != csv_table.count

      next if team.paid == count
      puts 'updated'
      team.update(paid: count)
      team.save!
    end
  end
end
