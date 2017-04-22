## Pre development analysis:

### View descriptions:
- 1. "Before continue..." - This screen only shows the user a message
	Labels:
		- Title
		- Message
	Controls:
		- 2 buttons at the bottom: Cancel, Continue

- 2. Chargeback - This screen lets the user lock/unlock the credit card, and send a chargeback request.
	Labels: 
		- Title
		- Lock button label
		- 2x Custom Switches labels (Color: When on is green, When off is grey)
		- Bottom message
	Controls:
		- 1 button at the top: Lock/Unlock card			
		- 2 switches: Does user know the establishment? Is the user carrying the card?
		- 2 buttons at the bottom: Cancel, Continue
		- 1 Text area with input enable

- 3. "Done message" - This informs the user the chargeback request was sent
	Labels:
		- Title
		- Message
	Buttons:
		- Close


#### Screen 1
	This view is presented as an overlay, and uses the default overlay view background (#fdfdfd)
	- Title:
		- text: [Received from server] ("title")
		- color: Purple (#6e2b77)

	- Message:
		- text: [Received from server] ("description")
		- Text color: (black texts) #222222
		- Link color: (enabled purple) #6e2b77

	- Buttons: [Received from server]
		- "CONTINUAR" - ("primary_action") - Color: Enabled purple (#6e2b77)
			-> Takes user to next view [Received from server] ("links/chargeback/href")

		- "FECHAR" - ("secondary_action") - Dismisses current view - Color: Close grey (#808191)
		- color: Attributed string

	- Challenges:
		- The message description needs to be a webview - we receive an HTML from the server. Do not forget to setup the text and link colors of the webview. We might need an app CSS stylesheet here so that we can use the same style across all webviews the app uses.


#### Screen 2 (Chargeback)
	When user opens this screen, and the paremeter "autoblock" received from the server is true, we do a request to lock the card.

	- Title: [Received from the server]
		- text: [Received from the server] ("title")
		- color: #222222 (black texts)

	- Buttons: 
		- Lock/Unlock card button: Uses "locked_icon"/"unlocked_icon" - Text color: #d5171b (Red)
			- On tap, if the card is locked, it unlocks the card, but if the card is unlocked, it locks the card (do a POST request). The initial state is unlocked.

			- If card unlocked: 
				- Text: "Cartão desbloqueado, recomendamos mantê-lo bloqueado."
				- Icon: "unlocked_icon"
				- Action: POST request to [Received from server]("links/block_card/href") URL

			- If card locked: 
				- Text: "Bloqueamos preventivamente o seu cartão"
				- Icon: "locked_icon"
				- Action: POST request to [Received from server]("links/unblock_card/href") URL

		- "CANCELAR" - Dismisses current view. Color: Close grey (#808191)

		- "CONTESTAR" - Send the chargeback request
			- Action: POST Request to [Received from server] ("links/self/href")
			- Is enable when: User has typed a reason
			- Color:
				- Disabled: #cccccc (disabled_gray)
				- Enabled: #6e2b77 (enabled_purple)


	- Switches [received from server]("reason_details"):
		- Style: When On: (green)#417505  / When off: (#aba9ab) / Status Text: White
		- "merchant_recognized" 
		- "card_in_possession"

	- Textarea: (edit on)
		- Uses attributed placeholder or webview?
		- Placeholder color: hint (#999999)

	- Challenges:
		- Textarea vs Keyboard: The content can easily overflow the view when keyboard is visible.
		- Custom switches: Can we reuse the default UISwitch, just customizing, or we need a new one? (Not 100% confident I can resize the default UISwitch)


#### Screen 3 (Request sent)
	Informs the user that the chargeback request was sent.
	- Buttons:
		- "Close"
			- Text: Fechar
			- Color: close_gray (#808191)

	- Labels:
		- Title:
			- Text: "Contestação de compra recebida"
			- Color: (purple titles) #6e2b77
		- Message: 
			- Text: "Fique de olho no seu email! Nos próximos 3 dias você deverá receber um primeiro retorno sobre sua contestação"
			- Color: (black texts) #222222

### Questions: 
- Color of the "reason" textfield text: The mocks only shows the placeholder text color.