--------------------------------------------------------------------------------
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2012 Corona Labs Inc. All Rights Reserved.
--------------------------------------------------------------------------------


-- Import optional Lua libraries.
local widget = require("widget")
local analytics = require("analytics")


-- Hide the status bar.
display.setStatusBar(display.HiddenStatusBar)


-- Display an orange background.
display.setDefault("background", 1.0, 0.65, 0)


-- Log an event to Flurry analytics.
-- *** You must provide a valid app ID in order to init() the Flurry analytics feature. ***
analytics.init("MyAppId")
analytics.logEvent("My Event ID")


function onRelease()
	native.showAlert( "Ding!", "button pushed" )
end
alertButton = widget.newButton
{
	defaultFile = "buttonBlue.png",
	overFile = "buttonBlueOver.png",
	label = "Push the button",
	labelColor = 
	{ 
		default = { 1.0, 1.0, 1.0 }, 
	},
	font = native.systemFontBold,
	emboss = true,
	onRelease = onRelease,
}
alertButton.x = display.contentWidth / 2
alertButton.y = (display.contentHeight / 2) + (alertButton.contentHeight / 2)
