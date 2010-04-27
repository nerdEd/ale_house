Factory.define :neighborhood do |n|
  n.name 'Fells Point'
  n.lat '23.0090'
  n.long '-45.0908'
  n.description 'By the water, east of convention center.'
end

Factory.define :bad_neighborhood, :class => Neighborhood do |n|
  n.description 'Very Bad Neighborhood!'
end