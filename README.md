
# D360TesterKit

The `D360TesterKit` is a small framework that can simulate the 360dialog campaings for testing or demonstration purposes. 

⚠️ ⚠️ Please note that this framework is not inteded for production use and it's sole purpose is to facilitate the 360dialog SDK integration. 

In fact, if this framework is included in an app built for production, it will crash the app to assert that the framework is not shipped by mistake in production.

![](logo.png)


## Installation

Only [Carthage](https://github.com/Carthage/Carthage) is supported.

- Cartfile

	```bash
	# Cartfile
	github "360dialog/sdk-tester-ios"
	```

- Run  `bash carthage update --use-ssh`
- Add the `D360TesterKit.framework` to your app

### Usage


- InboxMessage with a DeepLink action

	```swift
	let campaign = DTInbox(title: "Hi 👋", body: "Tap to open the Maps app")
	        
	// You can customise the image url of the inbox attachment
	campaign.attachmentURL = URL(string: "https://pbs.twimg.com/profile_images/2566510432/ba1akm5czgzocd36xb2z_400x400.png")!
	
   // The inbox will have a Deeplink as action to the Map app as action when tapped
   campaign.action = DTURLAction(url: URL(string:"http://maps.apple.com/?ll=52.5287174,13.4154767")!)

	DTTester.send(campaign)
	```
	
- InboxMessage with a InApp action

	```swift
	let campaign = DTInbox(title: "Hi 👋", body: "Tap to open an InApp Message")
	        
	
   // The inbox will have a InApp as action when tapped
   campaign.action = DTInAppAction()

	DTTester.send(campaign)
	```

- Simulate a sample InAppMessage:

	```swift
	// This inapp is a default 360dialog inapp and you can send it as it is.
	let campaign = DTInApp()
	
	// optionally, you can supply your own HTML to the InApp
	// campaign.url = URL(string: "https://inapp-samples.s3.amazonaws.com/push-permissions.html")!
	
	DTTester.send(campaign)

	```

- Simulate a native push notification:

	```swift
	let campaign = DTNotification(title: "Hi 👋", body: "Tap to open a URL")

	// Set the URL of the rich content
   campaign.richURL = URL(string: "https://inapp-samples.s3.amazonaws.com/examples/JPG/desertsmall.jpg")!
        	    
	// By default, the notification is a foreground notification. You can disable it here
	// campaign.isForeground = false

	    
	DTTester.send(campaign)
	```



