# Payment chargeback simple flow

Implementation of a simple purchase chargeback flow.

The intent of this project is to build a simple and easy purchase chargeback user experience.

## Pre development analysis

Before coding, a general project analysis was done, based on the provided mocks and business logic.
You can check the specs in the [SPECS.md](SPECS.md) file.

## Implementation proposition

The iOS implementation proposition was written based on the specs. It describes some implementation approaches to accomplish the expected features. You can find the proposition in the [PROPOSITION.md](PROPOSITION.md) file.

## Architecture - Minimalist VIPER
This app was developed using a minimalist and simplified version of the VIPER (backronym for View, Interactor, Presenter, Entity and Routing) architecture (check the [References](##References) section for more information), which is an alternative to the MVC (model-view-controller) architecture. The advantage of this architecture is that it allow us to divide the app's logic into distinct layers of responsibility, and fits perfect when developing  using TDD.

## App structure explanation
---
 This section will provide a briefly explanation about the app's implementation.

#### `AppDelegate`: 

The `AppDelegate` will create a `UIWindow` and ask the `HomeViewWireframe` 
 for a navigation controller and present it in its window.
<hr />

### Home module

#### `HomeViewWireframe`:
`static func createNavigation() -> UINavigationController`: <br />
 Returns a navigation controller with a `HomeViewController` view controller as its root view controller. This method does all the dependency injection.

#### `HomePresenter`:
`func loadPageContent()`: <br />
Ask to its `api` for the view's content, and then asks the view to present the loaded page after receiving the api response.

`func didSelectLink(_ link: AppApiLink)`:  <br/>
The view can have multiple links. The view notifies when user selects one of them. The presenter will ask the `api` for the selected link page content, and will route to the next page.

#### `HomeViewController`:
`func refresh(withPage page: HomePage)`: <br />
After the content is loaded, this method is called passing the new view data to be displayed. Here the view's content is reloaded.

`func showEmptyState(_ shouldShow: Bool)`: <br />
If the presenter fail loading the content, we will not have content to present, so we display an empty state explaning the use an error may have happened.

<hr />

### Notice module:
This is a generic notice view. It can display a title, a message (support html) and one or more actions.

#### `NoticePage`: (view model)
This class holds the information the view will present.
- `title`: The title of the notice page
- `description`: The notice message. It's an attributed string with `HTML` content
- `actions`: Holds the actions the user can take. Usually displayed as a list of buttons, but it is up to the view to decide how it will be shown
- `links`: The links used to launch the actions. 
- `descriptionStyleSheet`: This property holds the `description` style sheet (stored in a file in the bundle).


#### `NoticeWireframe`:
`static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController)`: <br />
Creates the notice module and does all the dependencies injection.

`func dismiss(completion: (() -> Void)?)`: <br />
Dismiss the presented notice modal view.

`func launch(wireframeOfType: AppPageWireframe.Type, withPage rawPage: [String: AnyObject])`: <br />
Navigates to the next page. It launches a wireframe with a page loaded from the server. The `wireframeOfType` parameter specifies the wireframe that will be used to display the page.

#### `NoticePresenter`:
`func didTapAction(action: NoticePage.Action, inPage page: NoticePage)`: <br />
Execute the action the use selected in the view by either dismissing the view or routing to the next page based on the selected action.

#### `NoticeViewController`:
`func presentPage(_ page: NoticePage)`: <br />
Reload the view presenting the content passed as a parameter. The content can come from the server or can be a static page.

<hr />

### Chargeback module:
This module shows the `chargeback` page type. the `ChargebackPage` class holds the information the view will display. This page requires user input, and can be submitted with the input further.

#### `ChargebackPage`:
Holds all the information the view can display. As its content can be submitted, this class has methods that validates its containing data.

#### `ChargebackWireframe`:
`func chargebackDone()`: <br />
Once the chargeback flow is done, the view is dismissed and a notice page is presented to the user informing the chargeback was successfully done.

`func chargebackCanceled()`: <br />
If the the chargeback flow is interrupted we dismiss the view right away.

`static func launchModule(rawPage: [String: AnyObject], fromViewController: UIViewController)`: <br />
Creates the chargeback module and does all the dependencies injection.

#### `ChargebackPresenter`:
`func toggleCardStatus(fromPage: ChargebackPage)`: <br />
Toggle between lock and unlocked card statuses. The current card status that will be toggled is based on the `fromPage` parameter page content.

`func didTapCancel()`: <br />
Asks the `wireframe` to dismiss the view if the chargeback flow is interrupted.

`func submitPage(_ page: ChargebackPage) `: <br />
Submit a page to the server. The `page` parameter should contain the data will be submitted.

#### `ChargebackViewController`:
`func setCardLocked(isLocked locked: Bool)`: <br />
Display the current card status. Updates the card status button style based on the `locked` parameter.

`func presentPage(_ page: ChargebackPage)`: <br />
Reload the view presenting the content passed in the `page` parameter.

<hr />

## Custom views
To achieve the UI provided in the mocks and be able to reuse them in new views can be created firther, some custom views were created and encapsulated in its own class.

The advantage of having custom views, is that all the styling code can live in the view class. Instead of having for example a view controller customizing a button label and icon based on different states, we abstract the style of each state in the view implementation.

#### `UICustomSwitch`
A customized version of the `UISwitch`. Have some levels of color customization and animations when touching up/down.

The decision to create this custom class instead of using the native one, is that we want to guarantee our view will match the mocks even if the system changes its default `UISwitch` style.

#### `ToggleCardStatusButton`:
A subclass of the `UIButton` system class. Has an icon on the left side, and a text on the right. Supports two different states: 
- `ToggleCardStatusButtonMode.locked`: The text and the icon shows a message informing the card is locked
- `ToggleCardStatusButtonMode.unlocked`: The text and the icon shows a message informing the card is unlocked

<br />

<hr />

## Localization
All the strings used in the app are localized and live in the `Localizable.strings` file. Currently we only support `pt-BR`.

<hr />

## Accessibility

All the screens were audited and are accessible and can be used with the `Voice over` active.

<hr />

## Tests

A test was written to test the `HomePresenter` features.

`func testGetPageContent()`: Check if the presenter is calling the `api` to get the page content

`func testLoadingState()`: Test if the presenter is asking the view to present the loading state before fetching data from the server.

` func testLoadContentSuccess()`: Test if the presenter is asking the view to refresh the content after receiving the data from the server.

`func testLoadContentFailed()`: Test if the the presenter is asking the view to present an error message if the content load fails.

`func testLinkSelection()`: Test if the presenter routes the selected link properly. Also checks if it is asking the view to present a load content state before fetching the next page data.

`func testLinkRouteSuccess()`: Test if the presenter is asking the presenter to launch the next after the route is done.

`func testLinkRouteFailed()`:  Test if the presenter is asking the view to present an error message in case the routing fails.

<hr />

## References


[Objc.io - Issue 13 ](https://www.objc.io/issues/13-architecture/viper/)<br />
[Mutual Mobile - Viper Introduction](http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/) <br />
[AFNetwroking Github's repository](https://github.com/AFNetworking/AFNetworking) <br />
[SVProgressHUD Github's repository](https://github.com/SVProgressHUD/SVProgressHUD) <br />
[Cocoapods official website](https://cocoapods.org/)