App.highlight = App.cable.subscriptions.create { channel: "HighlightChannel" },
  received: (data) ->
    if data['type'] == 'Channel'
      $('.channel_'+data['id'] + ' a').addClass('channel_highlight')
    else
      $('.user_'+data['id'] + ' a').addClass('talk_highlight')