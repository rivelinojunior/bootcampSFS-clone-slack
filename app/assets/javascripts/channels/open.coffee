window.open_channel = (channel_id) ->
  $.ajax '/channels/' + channel_id,
    type: 'PUT'
    dataType: 'json'
    success: (data, text, jqXHR) ->
      $('.btn_channel_'+channel_id).removeClass('channel_highlight')
    error: (jqXHR, textStatus, errorThrown) ->
      Materialize.toast('Problem to open this channel<b>:(</b>', 4000, 'red')