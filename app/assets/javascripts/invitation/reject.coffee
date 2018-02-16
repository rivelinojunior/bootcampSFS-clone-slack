$(document).on 'turbolinks:load', ->
  $(".btn-reject-invitation").on 'click', (e) =>
    invitation_id = e.target.dataset["invitationId"]
    $.ajax '/invitations/'+invitation_id,
        type: 'DELETE',
        success: (data, text, jqXHR) ->
          $('#invitation-'+invitation_id).remove()
          Materialize.toast('Success in reject invite <b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          debugger
          Materialize.toast('Problem in reject invite <b>:(</b>', 4000, 'red')

    return false