## Pre development analysis:

### View descriptions:

- 3 screens:
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
		- text: "Antes de continuar" 
		- color: Purple (#6e2b77)
	- Message:
		- text: [received from erver]
			Estamos com você nesta! Certifique-se dos pontos abaixo. são muito importantes:
			- Você pode [procurar o nome do estabelecimento no Google.](Link google) Diversas vezes encontramos informações valiosas por lá e elas podem te ajudar neste processo.
			- Caso você reconheça a compra, é muito importante para nós que entre em contato com o estabelecimento e certifique-se de que a situação já não foi resolvida.
	- Buttons:
		- "CONTINUAR" - Go to next view - Color: Enabled purple (#6e2b77)
		- "FECHAR" - Dismisses current view - Color: Close grey (#808191)
		- color: Attributed string

	- Challenges:
		- The message description needs to be a webview - we receive an HTML from the server


#### Screen 2 (Chargeback)
	When user opens this screen, and the paremeter "autoblock", received from the server, is true, we do a request to lock the card.
	- Title:
		- text: "Não reconheço esta compra" [Received from the server]
		- color: #222222 (black texts)
	- Buttons: 
		- Lock/Unlock card button: Uses "locked_icon"/"unlocked_icon" - Text color: #d5171b (Red)
			- On tap, if the card is locked, it unlocks the card, but if the card is unlocked, it locks the card (do a POST request). The initial state is unlocked.
			- If card unlocked: 
				- Text: "Cartão desbloqueado, recomendamos mantê-lo bloqueado."
				- Icon: "unlocked_icon"
			- If card locked: 
				- Text: "Bloqueamos preventivamente o seu cartão"
				- Icon: "locked_icon"

		- "CANCELAR" - Dismisses current view. Color: Close grey (#808191)
		- "CONTESTAR" - Send the chargeback requets:
			- Color:
				- Disabled: #cccccc (disabled_gray)
				- Enabled: #6e2b77 (enabled_purple)

	- Switches: - On/off - When On: (green)#417505  / WHen off: (#aba9ab) - Status Text: White
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

## Questions: 
- Color of the "reason" textfield text: The mocks only shows the placeholder text color.
