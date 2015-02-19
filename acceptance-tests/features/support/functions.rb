def create_property_in_elasticsearch(prop_data)

# these are the variables that are being set to insert test data
# the initial values are created in the $property_data hash and
# passed when the function is called

  house_number = prop_data['address']['house_number']
  street_name = prop_data['address']['street_name']
  postcode = prop_data['address']['postcode']
  position_x = prop_data['address']['position_x']
  position_y = prop_data['address']['position_y']
  p $es_client.inspect
  # this is the call to elastic search to insert test data
  $es_client.index index: 'TODO', type: 'TODO', id: 1, body: { todo: 'TODO' }
end

# connect to the database and execute the sql (that deletes everything)
def delete_all_properties
  $es_client.delete index: 'TODO', type: 'TODO', id: '1'
end
