Feature: View Copyright disclaimer

@US028  @Address_and_Map_copyright_disclaimer
Scenario: View Copyright disclaimer
  Given I am a citizen
  And I have a property
  When I view the property detail page
  Then the Address and Map copyright disclaimer should be displayed
