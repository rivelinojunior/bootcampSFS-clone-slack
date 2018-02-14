$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.exit_team', (e) ->
    user_id = e.currentTarget.dataset['userId']
    team_id = e.currentTarget.dataset['teamId']
    $('#exit_team_modal').modal('open')
    $('.exit_team_form').attr('action', 'team_users/' + user_id)
    $('#team_exit_id').val(team_id)
    $('#user_exit_id').val(user_id)
    return false

  $('.exit_team_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {
          team_id: $("#team_exit_id").val(),
          user_id: $("#user_exit_id").val()
        }
        success: (data, text, jqXHR) ->
          Materialize.toast('Success in exit the team &nbsp;<b>:(</b>', 4000, 'green') 
          run = () ->
            window.location.replace("/");
          setTimeout(run, 1000)
         
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem to exit the team &nbsp;<b>:(</b>', 4000, 'red')

    $('#exit_team_modal').modal('close')
    return false