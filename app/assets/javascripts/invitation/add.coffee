$(document).on 'turbolinks:load', ->
  $(".invitation_user").on 'click', (e) =>
    $('#invitation_user_modal').modal('open')
    $('#invitation_team_id').val(e.target.id)
    return false

  $('.invitation_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          invitation: {
            email: $('#invitation_email').val()
            team_id: $('#invitation_team_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          Materialize.toast('Success in invite User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in add User &nbsp;<b>:(</b>', 4000, 'red')


    $('#invitation_user_modal').modal('close')
    return false