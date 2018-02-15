json.invitations @invitations do |invitation|
  json.partial! "invitations/invitation", invitation: invitation
end