Feature: CSSPPFIP-24 LiveViewController Header

As a user I want to see the header with up to date info about current game

Scenario background: 
	Given I have Internet connection
	And I run the app
	And the app has connection with the server

Scenario: Basic flow - header view when match is on
	When a match is on
	Then I should be able to see the following header elements:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

Scenario outline: basic flow - switching between table view and map view
	When a match is on
	And I <"switch"> views
	Then the following header elements should be displayed:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

	Examples:

	|switch                      |
	| from table view to map view|
	| from map view to table view|

Scenario: Alternative flow - no match on
	When there's no match on
	Then the following header elements should not be displayed:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

	And I should see a message "Poczekaj chwilę! Mecz prawdopodonie jeszcze się nie rozpoczął"

Scenario outline: alternative flow
	When a match is on
	And <"disturbance"> occurs
	Then the following header elements should not be displayed:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

	And I should see a <"message"> 

	Examples:

	| disturbance              | message                                                                |
	| Internet connection lost | "Aplikacja nie ma dostępu do internetu, sprawdź połącznie internetowe" | 
	| server connection lost   | "Couldn't load now playing game"                                       |



Scenario: Alternative flow - no Internet connection
	Given I run the app
	When there's <"no connection">
	Then the following header elements should not be displayed:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

	And I should see a <"message"> 

	| no connection | message                                                                |
	| Internet      | "Aplikacja nie ma dostępu do internetu, sprawdź połącznie internetowe" |
	| server        | "Aplikacja nie ma dostępu do serwera"                                  |


Scenario background:
	Given I run the app
	And I have Internet connection
	And the app has connection with the server
	And a match is on

Scenario: Window focus change, app is back from the background
	
	When I put the app to the background
	And I put the app back to the foreground after "given amount of time"
	Then I should be able to see the following header elements:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

Scenario: Alternative flow - window focus change, app is back from the background after running another app
	When I put the app to the background
	And I run another app
	And I put another app to the background
	And I put the app back to the foreground after "given amount of time"
	Then I should be able to see the following header elements:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |

Scenario: Alternative flow - incoming call
	When I receive an incoming call
	And the call is finished
	Then I should be able to see the following header elements:

	| identifier        |
	| roundLabel        |
	| scoreLabel        |
	| remainingTimeLabel|
	| t_icon            |
	| ct_icon           |




