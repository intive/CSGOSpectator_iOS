Feature: CSSPPFIP-31 Create map view controller

Scenario background:
	Given I run the app
	And I have Internet connection
	And there's connection to the server
	And the game is on
	And I switch to from the table view to the map view
	Then I should see the following elements:
	
	 | elements      |
	 | header        |
	 | map           |
	 | liveButton    |
	 | historyButton |