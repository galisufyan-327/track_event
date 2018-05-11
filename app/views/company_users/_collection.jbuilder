json.company_user @company_users do |company_user|
  json.partial! 'company_users/attributes', company_user: company_user
end
