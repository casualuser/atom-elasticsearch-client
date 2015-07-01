{BaseCommand} = require './base'
{showFieldsListView} = require '../views/fields-list-view'


module.exports =
class IndicesGetFieldMapping extends BaseCommand

  run: ({field}={}) ->
    if not field
      options =
        client: @client
        index: @index
        docType: @docType

      return showFieldsListView(options, (item) ->
        new IndicesGetFieldMapping(field: item.name)
      )

    options =
      index: @index
      type: @docType
      field: field

    @client.indices.getFieldMapping(options, @showResult)
