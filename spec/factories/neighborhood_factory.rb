Factory.define :neighborhood do |n|
  n.name 'Fells Point'
  n.description 'By the water, east of convention center.'
end

Factory.define :bad_neighborhood, :class => Neighborhood do |n|
  n.description 'Very Bad Neighborhood!'
end