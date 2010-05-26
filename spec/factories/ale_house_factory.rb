Factory.define :ale_house do |a|
  a.name 'Berthas'
  a.description 'Best mussels in Baltimore'
  a.address 'Aliceanna & Broadway'
  a.association :neighborhood
  a.lat '23.09898'
  a.long '-44.09890'
  a.url 'http://www.somefakewebsite.com'
end

Factory.define :zerthas, :class => AleHouse do |a|
  a.name 'Zerthas'
  a.description 'Zest mussels in Baltimore'
  a.address 'Aliceanna & Broadway'
  a.association :neighborhood
  a.lat '23.09898'
  a.long '-44.09890'
  a.url 'http://www.somefakewebsite.com'
end

Factory.define :bad_ale_house, :class => AleHouse do |a|
  a.name 'Bad Ale House'
end