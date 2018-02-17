$(document).on 'turbolinks:load', ->
  $(".btn-accept-invitation").on 'click', (e) =>
    invitation_id = e.target.dataset["invitationId"]
    $.ajax '/invitations/'+invitation_id,
        type: 'PUT',
        success: (data, text, jqXHR) ->
          run = () ->
            window.location.replace("/");
          setTimeout(run, 1000)
          Materialize.toast('Success in invite User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in add User &nbsp;<b>:(</b>', 4000, 'red')

    return false