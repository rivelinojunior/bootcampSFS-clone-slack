$(document).on 'turbolinks:load', ->
  $(".btn-accept-invitation").on 'click', (e) =>
    invitation_id = e.target.dataset["invitationId"]
    $.ajax '/invitations/'+invitation_id,
        type: 'PUT',
        success: (data, text, jqXHR) ->
          $('#invitation-'+invitation_id).remove()
          Materialize.toast('Success in invite User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          debugger
          Materialize.toast('Problem in add User &nbsp;<b>:(</b>', 4000, 'red')

    return false