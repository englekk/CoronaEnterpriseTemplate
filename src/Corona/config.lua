----------------------------------------
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
----------------------------------------

if system.getInfo("model") == nil then return end -- for HTML5

local aspectRatio = display.pixelHeight / display.pixelWidth

application =
{
  content =
  {
    width = aspectRatio > 1.5 and 360 or math.ceil( 480 / aspectRatio ),
    height = aspectRatio < 1.5 and 480 or math.ceil( 360 * aspectRatio ),
    scale = "letterBox",
    audioPlayFrequency = 44100, -- 11025, 22050, 44100: 높을수록 고음질
    fps = 60,
    xAlign = "left",
    yAlign = "top",
    imageSuffix =
    {
      ["@2x"] = 1.5,
      ["@4x"] = 3.0,
    },
  },
  --[[notification =
  {
    iphone =
    {
      types =
      {
        "badge", "sound", "alert"
      }
    },
    google =
    {
      projectNumber = "000000000000"
    },
  }]]
}