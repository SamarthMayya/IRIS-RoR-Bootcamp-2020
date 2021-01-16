class Cricketer < ApplicationRecord
  # Select players from the country 'Australia'
  scope :australian_players, -> { where(country: 'Australia') }

  # Select players with the role 'Batter'
  scope :batters, -> { where(role: 'Batter') }

  # Select players with the role 'Bowler'
  scope :bowlers, -> { where(role: 'Bowler') }

  # Sort players by the descending number of matches played
  scope :descending_by_matches, -> { all.order(matches: :desc) }

  # Batting average: Runs scored / (Number of innings in which player has been out)
  #
  # Note:
  # - If any of runs scored, innings batted and not outs are missing,
  #   return nil as the data is incomplete.
  # - If the player has not batted yet, return nil
  # - If the player has been not out in all innings, return runs scored.
  def batting_average
    if(runs_scored.nil? || innings_batted.nil? || not_out.nil? )
      return nil
    elsif(not_out == innings_batted )
      return runs_scored
    end  
    runs_scored.to_f/(innings_batted - not_out) 
  end

  # Batting strike rate: (Runs Scored x 100) / (Balls Faced)
  #
  # Note:
  # - If any of runs scored and balls faced are missing, return nil as the
  #   data is incomplete
  # - If the player has not batted yet, return nil
  def batting_strike_rate
    if( runs_scored.nil? || balls_faced.nil? || balls_faced == 0)
      return nil 
    end 
    runs_scored.to_f * 100 / balls_faced 
  end

  # Create records for the classical batters
  def self.import_classical_batters
    Cricketer.create(name: 'Sachin Tendulkar', country: 'India', role: 'Batter', matches: 200, innings_batted: 329, runs_scored: 15921, not_out: 33, high_score: 248, centuries: 51, half_centuries: 68)
    Cricketer.create(name: 'Rahul Dravid', country: 'India', role: 'Batter', matches: 164, innings_batted: 286, runs_scored: 13288, not_out: 32, high_score: 270, balls_faced: 31258, centuries: 36, half_centuries: 63)
    Cricketer.create(name: 'Kumar Sangakkara', country: 'Sri Lanka', role: 'Wicketkeeper', matches: 134, innings_batted: 233, runs_scored: 12400, not_out: 17, high_score: 319, balls_faced: 22882, centuries: 38, half_centuries: 52)
    Cricketer.create(name: 'Ricky Ponting', country: 'Australia', role: 'Batter', matches: 168, innings_batted: 287, runs_scored: 13378, not_out: 29, high_score: 257, balls_faced: 22782, centuries: 41, half_centuries: 62)
    Cricketer.create(name: 'Brian Lara', country: 'West Indies', role: 'Batter', matches: 131, innings_batted: 232, runs_scored: 11953, not_out: 6, high_score: 400, balls_faced: 19753, centuries: 34, half_centuries: 48)
  end

  # Update the current data with an innings scorecard.
  #
  # A batting_scorecard is defined an array of the following type:
  # [Player name, Is out, Runs scored, Balls faced, 4s, 6s]
  #
  # For example:
  # [
  #   ['Rohit Sharma', true, 26, 77, 3, 1],
  #   ['Shubham Gill', true, 50, 101, 8, 0],
  #   ...
  #   ['Jasprit Bumrah', false, 0, 2, 0, 0],
  #   ['Mohammed Siraj', true, 6, 10, 1, 0]
  # ]
  #
  # There are atleast two batters and upto eleven batters in an innings.
  #
  # A bowling_scorecard is defined as an array of the following type:
  # [Player name, Balls bowled, Maidens bowled, Runs given, Wickets]
  #
  # For example:
  # [
  #   ['Mitchell Starc', 114, 7, 61, 1],
  #   ['Josh Hazzlewood', 126, 10, 43, 2],
  #   ...
  #   ['Cameron Green', 30, 2, 11, 0]
  # ]
  #
  # Note: If you cannot find a player with given name, raise an
  # `ActiveRecord::RecordNotFound` exception with the player's name as
  # the message.
  def self.update_innings(batting_scorecard, bowling_scorecard)
    batting_scorecard.each do |batting_scorecard1|
      bat = Cricketer.find_by(name: batting_scorecard1[0])
      if( !bat )
        raise ActiveRecord::RecordNotFound.new(message=batting_scorecard[0]) 
      end 
      bat.innings_batted += 1
      bat.runs_scored += batting_scorecard1[2]
      bat.balls_faced += batting_scorecard1[3]
      if( !batting_scorecard1[1] )
        bat.not_out += 1
      end 
      if( batting_scorecard1[2] >= 100 )
        bat.centuries += 1
      end 
      if( batting_scorecard1[2] >= 50 )
        bat.half_centuries += 1
      end 
      bat.high_score = [bat.high_score, batting_scorecard1[2]].max
      bat.fours_scored += batting_scorecard1[4]
      bat.sixes_scored += batting_scorecard1[5]
      bat.save 
    end 
    bowling_scorecard.each do |bowling_scorecard1|
      bowl  = Cricketer.find_by(name: bowling_scorecard1[0])
      if( !bowl )
        raise ActiveRecord::RecordNotFound.new(message=bowling_scorecard1[0])
      end 
      bowl.innings_bowled += 1
      bowl.balls_bowled += bowling_scorecard1[1]
      bowl.runs_given += bowling_scorecard1[3]
      bowl.wickets_taken += bowling_scorecard1[4] 
      bowl.save  
    end 
  end

  # Delete the record associated with a player.
  #
  # Note: If you cannot find a player with given name, raise an
  # `ActiveRecord::RecordNotFound` exception.
  def self.ban(name)
    x = Cricketer.find_by(name: name)
    if( !x )
      raise ActiveRecord::RecordNotFound 
    end 
    x.destroy
  end
end
