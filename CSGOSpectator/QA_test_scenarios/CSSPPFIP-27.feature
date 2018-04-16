Feature: CSSPPFIP-27 Adding blurred background to the LiveViewController

Background scenario:
	Given I run the app
	And I am on the table view

Scenario outline: Blurred background on the table view
	When I'm on the table view
	And one of the <"situation"> is happening
	Then I should see it on the blurred background

	Examples:
	| situation             |
	| match is on           |
	| no match              |
	| no server connection  |
	| no Internet connection|

Background scenario:
	Given I run the app
	And I am on the map view

Scenario outline: Blurred background on the map view
	When I'm on the map view
	And one of the <"situation"> is happening
	Then I should see it on the blurred background

	Examples:
	| situation             |
	| match is on           |
	| no match              |
	| no server connection  |
	| no Internet connection|
