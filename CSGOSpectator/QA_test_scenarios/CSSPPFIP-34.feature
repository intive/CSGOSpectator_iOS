Feature: CSSPPFIP-34 Adding map view controller to page view controller

As a user I want to be able to switch from page view controller to map view controller

Scenario outline:
	Given I have Internet connection
	And I run the app
	And there's connection with the server
	When I <"switch"> screen
	Then the following elements should be displayed

	| element       |
	| minimap       |
	| header        |
	| Live_button   |
	| History_button|

	
	Examples:
	| switch          |
	| using SWIPE WPF |
	| using tap       |



	

	