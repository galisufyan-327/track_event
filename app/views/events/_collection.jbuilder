json.events events do |event|
  json.partial! 'events/attributes', event: event
end
