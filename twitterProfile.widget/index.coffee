#-----------------------------------------------------------------------#
# Twitter Profile Widget for Übersicht
# Created April 2020 by Johannes Hubig

# Position of the widget on your screen
pos_top		= '540px'
pos_left	= '650px'

# THEME OPTIONS: bright, dark, striped or color	(default/blank is bright)
theme		= 'bright'

# Your twitter account you want to see
twitter_account = "felx"

#-----------------------------------------------------------------------#

if theme == 'dark'
  labelColor	= 'WHITE'
  followerColor		= 'WHITE'
  profileNameColor	= 'WHITE'
  bkground		= 'rgba(#000, 0.8)'
  opacityLevel	= '0.9'
  twttrIconSrc = "twitterProfile.widget/Twitter_Social_Icon_Circle_White.svg"
  twttrIconOpacityLevel = '0.4'
  twttrBackground = 'none'
  backgroundImage = 'none'
  backgroundSize = 'auto auto'

else if theme == 'bright'
  labelColor	= 'WHITE'
  followerColor		= 'BLACK'
  profileNameColor	= '#1DA1F2'
  bkground		= 'rgba(#fff, 1)'
  opacityLevel	= '0.9'
  twttrIconSrc = "twitterProfile.widget/Twitter_Social_Icon_Circle_Color.svg"
  twttrIconOpacityLevel = '0.8'
  twttrBackground = 'none'
  backgroundImage = 'none'
  backgroundSize = 'auto auto'

else if theme == 'color'
  labelColor	= 'WHITE'
  followerColor		= 'WHITE'
  profileNameColor	= 'WHITE'
  bkground		= 'rgba(#1DA1F2, 0.8)'
  opacityLevel	= '0.9'
  twttrIconSrc = 'twitterProfile.widget/Twitter_Social_Icon_Circle_White.svg'
  twttrIconOpacityLevel = '0.8'
  twttrBackground = 'none'
  backgroundImage = 'none'
  backgroundSize = 'auto auto'

else if theme == 'striped'
  labelColor	= 'WHITE'
  followerColor		= 'BLACK'
  profileNameColor	= 'BLACK'
  bkground		= 'rgba(#1DA1F2, 0.8)'
  opacityLevel	= '0.9'
  twttrIconSrc = 'twitterProfile.widget/Twitter_Social_Icon_Circle_White.svg'
  twttrIconOpacityLevel = '1'
  twttrBackground = '#1DA1F2'
  backgroundImage = 'linear-gradient(45deg, #FFF 25%, #1DA1F2 25%, #1DA1F2 50%, #FFF 50%, #FFF 75%, #1DA1F2 75%, #1DA1F2 100%)'
  backgroundSize = '14.14px 14.14px'

else
  labelColor	= 'WHITE'
  followerColor		= 'BLACK'
  profileNameColor	= '#1DA1F2'
  bkground		= 'rgba(#fff, 1)'
  opacityLevel	= '0.8'
  twttrIconSrc = 'twitterProfile.widget/Twitter_Social_Icon_Circle_Color.svg'
  twttrIconOpacityLevel = '0.8'
  twttrBackground = 'none'
  backgroundImage = 'none'
  backgroundSize = 'auto auto'

command: "curl -H \"Content-Type: application/json\" \"https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=#{twitter_account}\" 2>/dev/null"

# Update every hour
refreshFrequency: 3600000

style: """
  top:	#{pos_top}
  left:	#{pos_left}
  font-family: Avenir Next
  color: #{profileNameColor}

  div
    display: block
    border-radius 15px
    text-shadow: 0 0 1px #{bkground}
    background: #{bkground}
    font-size: 16px
    font-weight: 400
    opacity: #{opacityLevel}
    padding: 4px 8px 4px 6px
    width: 170px
    background-image: #{backgroundImage}
    background-size: #{backgroundSize}

  .profile_name
    font-size: 14px
    font-weight: 600
    margin-left: 43px
    color: #{profileNameColor}
    margin-top: -100px

  .followers_count
    padding: 0
    margin: 0px
    margin-left: 43px
    font-size: 11px
    font-weight: 400
    max-width: 100%
    color: #{followerColor}
    text-overflow: ellipsis
    text-shadow: none

  img#profilePicture
    height: 36px
    width: 36px
    position: absolute
    top: 5px
    border-radius: 50%

  img#twitter_icon
    height: 22px
    width: 22px
    position: absolute
    opacity: #{twttrIconOpacityLevel}
    right: 10px
    top: 11px
    border-radius: 50%
    background: #{twttrBackground}

"""

render: -> """
  <div>
    <span class='profile_name'></span>
    <p class='followers_count'></p>
    <img id="profilePicture" src="https://avatars.io/twitter/#{twitter_account}" />
    <img id="twitter_icon" src="#{twttrIconSrc}" />
  </div>
"""

update: (output,domEl) ->
  output = output.replace(/["']/g, "") # Remove double quotes
  values		= output.split(",")
  twitterUsername = values[2].split(":")[1]
  followersCount 		= values[6].split(":")[1].split(" ")[0]
  div			= $(domEl)

  div.find('.profile_name').html(twitterUsername)
  div.find('.followers_count').html('Followers: ' + followersCount)
