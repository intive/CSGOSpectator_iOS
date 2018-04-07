Feature: CSSPPFIP-25_alternative_1 switching back from the map view 

As a user, after switching back from the map view I want to see the table view with all elements and current data about the game

Scenario background:
	Given I am on the map view
	And the match is on

Scenario outline:
	When I <"switch"> to the table view
	Then I should no longer see the minimap

	Examples:
	|switch|
	|using SWIPE WPF|
	|using tap|

Scenario background:
	Given I am on the map view
	And the match is on
	And I go back to the table view

Scenario outline: column labels
	When the match is on
	Then <"column_label"> should be displayed
	And it should be specifically ordered from left to right being column_label with <"number"> 1 a first one

Examples:
	| column_label | number |
	| K            | 1      |
	| D            | 2      |
	| A            | 3      |
	| MVP          | 4      |
	| SCORE        | 5      |

Scenario: playerCells
	When the match is on
	Then I should see <"quantity"> of playerCells with ctLabel <"label"> in counterBlue <"color"> on the left <"side"> of the table
	And I should see <"quantity"> of playerCells with tLabel <"label"> in terroristRed <"color"> on the right <"side"> of the table

	| quantity | label  | color       | side |
	| 5        | tLabel | counterBlue | left |
	| 5        | ctLabel| terroristRed| right|


Scenario outline: statistics
	When the match is on 
	And there are statistics available on the server

	| player_name  | scoreLabel | killsLabel | deathsLabel | assistsLabel | mvpLabel |
	| Pasha        | ...
	| Guru         | ...
	| BOT_Yani     | ...
	| Goat         | ...
	| BOT_Fred     | ...
	| SerekWiejski | ...
	| Nani         | ...
	| Lollipop     | ...
	| Fluffy       | ...
	| Amsterdam    | ...

	Then I should see the current data for: <"player_name">, <"assistsLabel">, <"deathsLabel">, <"mvpLabel">, <"scoreLabel">

	Examples:
	| player_name  | scoreLabel | killsLabel | deathsLabel | assistsLabel | mvpLabel |
	| Pasha        | ...
	| Guru         | ...
	| BOT_Yani     | ...
	| Goat         | ...
	| BOT_Fred     | ...
	| SerekWiejski | ...
	| Nani         | ...
	| Lollipop     | ...
	| Fluffy       | ...
	| Amsterdam    | ...
