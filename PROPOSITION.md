## Implementation proposition

### Mini VIPER:
	- Modules
		- Notice - Simple generic notice view. Can show a notice view containing the following UI components:
			- A title
			- A description message (can be a string or HTML)
			- 0 or n button actions

		- Chargeback - 
			- Allows user to submit a chargeback request
			- Allows user to block/unblock credit card

### Views:
	- NoticeViewController: This view shows a title, a description and two actions.
		- Features:
			- Description can be a simple String or a HTML text.
			- Can display 0 or n actions. 

		- Title: Shows data from "title" json property
		- Description: Shows data from "description" json property.

		Actions:
		- Primary action: Shows data from "primary_action" json property.
		- Secondary action: Shows data from "secondary_action" json property.

		- Action "continue" takes the user to the page URL in the ["links"]["chargeback"]["href"] JSON property.

	- ChargebackViewController: This view shows the "fraud" page id.
		Features:
			- When it launches, it should check for the "autoblock" json property. If its value is true, we should do a POST request to the url found in the ["links"]["block_card"]["href"] json property
			- When user taps the lock card button (that means the card is currently blocked), it does a POST request 
			to the URL found in the ["links"]["unblock_card"]["href"]
			- When user taps the unlock card button (that means the card is currently unblocked), it does a POST request to the URL found in the ["links"]["block_card"]["href"]
			- When user taps on "Contestar" button, we do a POST network request to the URL found in the ["links"]["self"]["href"] json property.
				- If the request is succeeded, we show the confirmaton notice
			- When user taps on "Cancelar", we dismiss the view

		- Title: Shows data from "title" json property
		- Block/Unblock card status: The initial status should be unblocked (although it can be changed right after launching if the "autoblock" property is true). The icon in the row shows the current status of the card. When user taps on the row, it should toggle the card status.
		- Reasons: Shows one row containing a label positioned on the left side, and a switch on the right side for each reason object received in the "reason_details" Json property
			- Each "reason_details" object has a "title" and "id" property.

### Misc

- Colors: Have a struct to store all theme colors.
- Network requests: AFNetworking?
- Overlay presentations : The views will be presented as a modal overlay. Do we need a custom transition iOS subclass to accomplish this? (UIViewControllerAnimatedTransitioning).