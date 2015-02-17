require 'open-uri'
require 'action_view'
require 'namecase'

class PropertyData

  def initialize(api_client)
    @api_client = api_client
  end

  def find(postcode, address_string)
    #TODO: remove this hardcoded case
    if postcode == "PL9 8TB" and address_string == "southernway_43"
      property_json = fake_address_json
    else
      property_json = get_property_json(postcode, address_string)
    end
    unless property_json["message"] == "No record found."
      format_property_json(property_json)
    end
  end

  private

  def get_property_json(postcode, address_string)
    @api_client.get("/properties/#{URI::encode(postcode)}/#{URI::encode(address_string)}")
  end

  def fake_address_json
    {
      "paon" => "43",
      "street" => "Southernway",
      "town" => "Plymouth",
      "postcode" => "PL9 8TB",
      "property_type" => "terraced",
      "coordinates" => {"latitude" => "100", "longitude" => "100"},
      "amount" => "250000",
      "date" => "04-04-2011",
    }
  end

  def unavailable_data
    "Not Available"
  end

  def format_property_json(property_json)
    coordinates = property_json["coordinates"]
    property_type = property_json["property_type"]
    address_hash = {
      :address => format_address(property_json),
      :property_type => property_type ? property_type.capitalize : unavailable_data,
      :price_paid_info => format_ppi(property_json)
    }
    # If coordinates are returned from the API then put these into address_hash
    if coordinates && coordinates["latitude"] && coordinates["longitude"]
      address_hash[:coordinates] = {:latitude => coordinates["latitude"], :longitude => coordinates["longitude"]}
    end
    address_hash
  end

  def format_address(property_json)
    saon = property_json["saon"]
    paon_street = ["paon", "street"].map do |key|
      property_json[key]
    end.compact.join(" ")
    rest_of_address = ["town", "county"].map do |key|
      property_json[key]
    end
    address_lines = ([saon, paon_street] + rest_of_address).compact
    capitalised_lines = address_lines.map do |address_line|
      NameCase(address_line)
    end
    capitalised_lines + [property_json["postcode"]]
  end

  def format_ppi(property_json)
    if property_json["date"] && property_json["amount"]
      date = DateTime.parse(property_json["date"]).strftime("%-d %B %Y")
      amount = ActionView::Base.new.number_with_delimiter(property_json["amount"])
      "£#{amount} on #{date}"
    else
      unavailable_data
    end
  end

end
