window.open_talk = (team_id, user_id) ->
  $.ajax '/talks/' + user_id,
    type: 'PUT'
    dataType: 'json',
    data: {
      team_id: team_id,
      user_id: user_id
    }
    success: (data, text, jqXHR) ->
      $('.btn_user_'+user_id).removeClass('talk_highlight')
    error: (jqXHR, textStatus, errorThrown) ->
      Materialize.toast('Problem to open this talk<b>:(</b>', 4000, 'red')