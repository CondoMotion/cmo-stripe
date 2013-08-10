# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

user = User.find_by_email("lparrish@hofeller.com")
company = Company.find_by_name("The Hofeller Company")
company.sites.each do |site|
  m = Membership.new
  m.site = site
  m.user = user
  m.role = Role.find_by_name("manager")
  m.save
end
user = User.find_by_email("msheingold@hofeller.com")
company = Company.find_by_name("The Hofeller Company")
company.sites.each do |site|
  m = Membership.new
  m.site = site
  m.user = user
  m.role = Role.find_by_name("manager")
  m.save
end

# company = Company.find_by_name("The Hofeller Company")
# company.sites.destroy_all
# site = company.sites.build(name: '1409 River Street  ', subdomain: 'river')
# address = site.build_address(address1: '1409 River Street', address2: '', city: 'Hyde Park', state: 'MA', zip: '02136')
# site.save
# site = company.sites.build(name: '197-205 Kent ', subdomain: 'kent') 
# address = site.build_address(address1: '197 Kent Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446')
# site.save
# site = company.sites.build(name: 'Cambridge Co-Housing ', subdomain: 'cambridge')
# address = site.build_address(address1: '175 Richdale Avenue', address2: '', city: 'Cambridge', state: 'MA', zip: '02140')
# site.save
# site = company.sites.build(name: 'Clarendon Hill ', subdomain: 'clarendon')
# address = site.build_address(address1: '1 Victoria Heights Road', address2: '', city: 'Hyde Park', state: 'MA', zip: '02136')
# site.save
# site = company.sites.build(name: 'Cliffmont ', subdomain: 'cliffmont') 
# address = site.build_address(address1: '57 Grew Avenue ', address2: '', city: 'Roslindale', state: 'MA', zip: '02131') 
# site.save
# site = company.sites.build(name: 'Colonial Arms ', subdomain: 'colonial-arms') 
# address = site.build_address(address1: '1488 Beacon Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446') 
# site.save
# site = company.sites.build(name: 'Court Condominium IV', subdomain: 'court-iv')
# address = site.build_address(address1: '399 Washington Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446')
# site.save
# site = company.sites.build(name: 'Covenant Residences on Commonwealth ', subdomain: 'covenant')
# address = site.build_address(address1: '27 Commonwealth Ave.', address2: '', city: 'Chestnut Hill', state: 'MA', zip: '02467') 
# site.save
# site = company.sites.build(name: 'Davenport Commons ', subdomain: 'davenport-commons') 
# address = site.build_address(address1: '951 Tremont Street', address2: '', city: 'Boston', state: 'MA', zip: '02120')
# site.save
# site = company.sites.build(name: 'Jamaica Pond Estate', subdomain: 'jamaica-pond') 
# address = site.build_address(address1: '100 Pond Street', address2: '', city: 'Jamaica Plain', state: 'MA', zip: '02130')
# site.save
# site = company.sites.build(name: 'Lawrence Manor ', subdomain: 'lawrence-manor') 
# address = site.build_address(address1: '15 Francis Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446')
# site.save
# site = company.sites.build(name: 'Marshall Place ', subdomain: 'marshall-place') 
# address = site.build_address(address1: '38 Marshall Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446') 
# site.save
# site = company.sites.build(name: 'Old Medford High ', subdomain: 'old-medford-high') 
# address = site.build_address(address1: '54 Forest Street', address2: '', city: 'Medford', state: 'MA', zip: '02155') 
# site.save
# site = company.sites.build(name: 'Parsons Field ', subdomain: 'parsons-field') 
# address = site.build_address(address1: '175 Kent Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446')
# site.save
# site = company.sites.build(name: 'Saint Paul Arms ', subdomain: 'saint-paul-arms') 
# address = site.build_address(address1: '150 Saint Paul Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446')
# site.save
# site = company.sites.build(name: 'Strathwick ', subdomain: 'strathwick') 
# address = site.build_address(address1: '46 Chiswick Road', address2: '', city: 'Brighton', state: 'MA', zip: '02135')
# site.save
# site = company.sites.build(name: 'The Montclair ', subdomain: 'montclair') 
# address = site.build_address(address1: '100 West Squantum St.', address2: '', city: 'Quincy', state: 'MA', zip: '02171') 
# site.save
# site = company.sites.build(name: 'The Ripley ', subdomain: 'ripley') 
# address = site.build_address(address1: '202 Perham Street', address2: '', city: 'West Roxbury', state: 'MA', zip: '02132') 
# site.save
# site = company.sites.build(name: 'Towne Lyne', subdomain: 'towne-lyne')
# address = site.build_address(address1: '35 Chiswick Road', address2: '', city: 'Brighton', state: 'MA', zip: '02135')
# site.save
# site = company.sites.build(name: 'Washington Square ', subdomain: 'washington-square') 
# address = site.build_address(address1: '309 Allston Street', address2: '', city: 'Brighton', state: 'MA', zip: '02135')
# site.save
# site = company.sites.build(name: 'Willow House ', subdomain: 'willow') 
# address = site.build_address(address1: '55 Saint Paul Street', address2: '', city: 'Brookline', state: 'MA', zip: '02446') 
# site.save