module Qualtrics
  class ResponseExportMapping
    include Kartograph::DSL

    kartograph do
      mapping ResponseExport
      root_key singular: 'result', scopes: [:read]

      scoped :read do
        property :percent_complete, key: 'percentComplete'
        property :file
      end
    end
  end
end
