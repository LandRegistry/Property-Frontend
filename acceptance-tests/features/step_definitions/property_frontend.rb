Given(/^I am a citizen$/) do
  # Do Nothing
end

Given(/^I have a property$/) do
# create a new hash that will contain address data
  @property_data = {
    "address_string" => "2D_CHAUCER_AVENUE_EXETER",
    "postcode"       => "EX2 6BR",
    "position_x"     => "293535.0",
    "position_y"     => "91115.0",
    "house_number"   => "2D",
    "street_name"    => "Chaucer Avenue",
  }

# calls a function to get rid of existing data to remove chance of duplicate rows
  delete_all_properties
# call the function that will insert our hash data into the database
  res = create_property_in_es(@property_data)
end

# go the url that is the property front -
# url is built using the address
# hash created above.
When(/^I view the property detail page$/) do
  postcode = @property_data['postcode'].gsub(" ", "_")
  address_string = @property_data['address_string']
  visit("http://landregistry.local:8000/property/#{postcode}/#{address_string}")
end

# then look for an xpath, assigning the value in to a var
# check the xpath value matches the initial value passed into the db
Then(/^I see the full address of the property$/) do
  postcode = page.find('//*[@id="content"]/div[1]/div[3]/div/div[1]/h2[5]')
  expect(postcode.text).to eq(@property_data['postcode'])

  street_name = page.find('//*[@id="content"]/div[1]/div[3]/div/div[1]/h2[2]')
  full_street_name = "#{@property_data['house_number']} #{@property_data['street_name']}"
  expect(street_name.text).to eq(full_street_name)
end

Given(/^I try to view a property that does not exist$/) do
# create a new hash that will contain address data for an address that doesn't exist
# we use this format so the address we create will be passed into the search URL
  @property_data = {
    "address_string" => "2D_CHAUCER_AVENUE_NARNIA",
    "postcode"       => "EX2 6BR",
    "position_x"     => -1.1111,
    "position_y"     => -2.2222,
  }
# remove existing properties from elasticsearch
  delete_all_properties
end

# looking for a non-existant address which should return a 'sensible' message
Then(/^I get a page not found message$/) do
# find the xpath to the object we want to check and assign to a variable
  message = page.find('//*[@id="content"]/h1')
# check that the xpath object contains the desired value
  expect(message.text).to eq('Property not found')
end

Then(/^I see the map to the correct coordinates$/) do
  latitude  = "50.709895171253535"
  longitude = "-3.509209803044564"
  map = page.find('//*[@id="content"]/div[1]/div[3]/div/div[2]/img')
  expect(map['src']).to include(latitude)
  expect(map['src']).to include(longitude)
end

Given(/^I have a property that does not have location coordinates$/) do
# create a new hash that will contain address data
  @property_data = {
    "address_string" => "2D_CHAUCER_AVENUE_EXETER",
    "postcode"       => "EX2_6BR",
  }
# remove existing properties from elasticsearch
  delete_all_properties
# add property to elasticsearch
  res = create_property_in_es(@property_data)
end

Then(/^a message is shown in place of the map section$/) do
  expect(page.body.text).to include ("No map available")
end

#this checks that there is a link and it is named correct on the page
Then(/^a hyperlink to LR statutory services should be available$/) do
  # find the link inside the paragraph which mentions the LR statutory services
  # this will fail if the link does not exist
  @link = page.find("//p[contains(.,'Access the Land Registry service')]/a")
end

When(/^I click the LR Statutory services link$/) do
  #do nothing
end

#this checks that the link points to the correct page
Then(/^I am taken to the Find a Property service$/) do
  expect(@link["href"]).to eq("https://www.gov.uk/search-property-information-land-registry")
end

Then(/^the Address and Map copyright disclaimer should be displayed$/) do
  # find the link with text about the terms and conditions
  @link = page.find("//a[text()='Use of this addressing data is subject to terms and conditions']")
  expect(@link["href"]).to eq("/property/copyright_notices")
  @link.click
  expect(page.body.text).to include ("You are granted a non-exclusive, royalty free, revocable licence solely to view the Licensed Data for non-commercial purposes for the period during which [insert name of Licensee] makes it available;")
  expect(page.body.text).to include ("You are not permitted to copy, sub-license, distribute, sell or otherwise make available the Licensed Data to third parties in any form;")
  expect(page.body.text).to include ("Third party rights to enforce the terms of this licence shall be reserved to Ordnance Survey;")
end
