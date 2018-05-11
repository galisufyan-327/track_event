json.reward_points @reward_points do |reward_point|
  json.partial! 'reward_points/attributes', reward: reward_point
end
