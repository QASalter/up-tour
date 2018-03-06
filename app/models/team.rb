class Team < ApplicationRecord
  belongs_to :club
  require 'csv'

  def self.update_team
   clubs_hash = {
    "Beach Cricket"                                    => 1,
    "Beach Flag Football"                              => 2,
    "Beach Football - Men's"                           => 3,
    "Beach Football - Women's"                         => 4,
    "Beach Rugby - Men's (7's)"                        => 5,
    "Beach Rugby - Women's (7's)"                      => 6,
    "Beach Volleyball - Mixed"                         => 7,
    "Cheerleading"                                     => 8,
    "Dance"                                            => 9,
    "Football - Men's (11 a Side)"                     => 10,
    "Hockey - Mixed"                                   => 11,
    "Lacrosse - Mixed (Social)"                        => 12,
    "Netball"                                          => 13,
    "Pole Dancing"                                     => 14,
    "Social Tourist - No sport participation included" => 15,
    "Swimming"                                         => 16,
    "Tennis - Mixed"                                   => 17 }


    csv_table = CSV.table('output.csv', {headers: false})

    csv_table.each do |person|
      next if person[0].nil?
      name = person[0].gsub("\t", '').gsub("\n", '')
      team = where(name: name).first_or_create do |team|
        team.name = name
        team.amount_paid = person[5]
        team.amount_left = person[6]
        team.club_id = clubs_hash[person[4]]
      end

      team.update(club_id: clubs_hash[person[4]]) if team.club_id != clubs_hash[person[4]]

      next if team.amount_paid == person[5]
      puts 'updated'
      team.update(amount_paid: person[5])
      team.update(amount_left: person[6])
      team.save!
    end
  end
end
