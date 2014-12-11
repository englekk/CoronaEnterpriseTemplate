--##############################  Main Code Begin  ##############################--
local composer = require( "composer" )

local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

-- -------------------------------------------------------------------------------

return scene
--##############################  Main Code End  ##############################--