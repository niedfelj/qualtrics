module Qualtrics::API
  class ResponseExportMapping
    include Kartograph::DSL

    kartograph do
      mapping ResponseExport
      root_key singular: "result", scopes: [:read]

      scoped :read do
        property :file_id, key: 'fileId'
        property :percent_complete, key: "percentComplete"
        property :status, key: 'status'
      end
    end
  end
end
