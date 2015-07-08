{CreateCommand} = require './base'
{showIndicesListView} = require '../views/indices-list-view'
notifications = require '../notifications'


module.exports =
class HelperCloseOpenIndex extends CreateCommand

  closeOpenIndex: (client, index) ->
    client.indices.close(index: index).
    then((response) ->
      client.indices.open(index: index).
      catch((error) ->
        throw error
      )
    ).
    then((response) ->
      notifications.addSuccess("Success")
    ).
    catch((error) ->
      notifications.addError("Error: #{error}", dismissable: true)
    )


  run: ({index}={})->
    if not index
      return showIndicesListView(@client, all: false, (item) ->
        new HelperCloseOpenIndex(index: item.index)
      )

    @closeOpenIndex(@client, index)
