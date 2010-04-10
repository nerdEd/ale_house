Factory.define :ale_house do |a|
  a.name 'Berthas'
  a.description 'Best mussels in Baltimore'
  a.address 'Aliceanna & Broadway'
end

Factory.define :bad_ale_house, :class => AleHouse do |a|
  a.name 'Bad Ale House'
end