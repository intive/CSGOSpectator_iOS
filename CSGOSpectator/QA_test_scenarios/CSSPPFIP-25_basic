Feature: CSSPPFIP-25_basic Basic flow - Table view in LiveViewController

As a user I want to see the table view elements with updated info about the current game players


Scenario background:
	Given I have Internet connection
	And I run the app
	And There's connection with the server

Scenario outline: Basic flow - column labels
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


Scenario: Basic flow - playerCells
	When the match is on
	Then I should see <"quantity"> of playerCells with ctLabel <"label"> in counterBlue <"color"> on the left <"side"> of the table
	And I should see <"quantity"> of playerCells with tLabel <"label"> in terroristRed <"color"> on the right <"side"> of the table

	| quantity | label  | color       | side |
	| 5        | tLabel | counterBlue | left |
	| 5        | ctLabel| terroristRed| right|


Scenario outline: Basic flow - statistics
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



