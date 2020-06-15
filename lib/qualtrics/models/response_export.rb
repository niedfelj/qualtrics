module Qualtrics::API
  class ResponseExport < BaseModel
    attribute :id
    attribute :percent_complete
    attribute :file
    attribute :status
    attribute :file_id

    # Unzips and maps the serialized responses to a Response object
    #
    # @return [Qualtrics::API::Response]
    def get_responses
      unzip_responses(file)
    end

    def get_raw_export 
      File.open("/tmp/qualtrics_response_export_#{id}.zip", "wb") { |f| f.write file }    
      
      contents = ""
      Zip::File.open("/tmp/qualtrics_response_export_#{id}.zip") do |zip|
        zip.each do |file|
          contents << file.get_input_stream.read
        end 
      end 
      
      File.delete("/tmp/qualtrics_response_export_#{id}.zip")
      
      contents 
    end 

    private

      # Creates a temporary zip file from api response, and maps the
      # contents of the file inside to an array of Qualtrics::API::Response models
      # TODO: Add CSV support
      # @return [Qualtrics::API::Response]
      def unzip_responses(response_zip)
        File.open("/tmp/qualtrics_response_export_#{id}.zip", "wb") { |f| f.write response_zip }
        responses = ""

        Zip::File.open("/tmp/qualtrics_response_export_#{id}.zip") do |zip|
          zip.each do |file|
            case file.name
            when /.+\.json/
              responses = create_responses(file.get_input_stream.read, :json)
            when /.+\.xml/
              responses = create_responses(file.get_input_stream.read, :xml)
            else
              raise Qualtrics::API::Error.new("Unkown Response Export file type for file: #{file.name}")
            end
          end
        end

        File.delete("/tmp/qualtrics_response_export_#{id}.zip")
        responses
      end

      # Sends the serialized responses to the correct mapping function
      # TODO: Add CSV Mapping
      # @return [Qualtrics::API::Response]
      def create_responses(serialized_responses, f_type)
        if (f_type == :json) || (f_type == :xml)
          responses = ResponsesMapping.from_json_or_xml(serialized_responses, f_type)
        end

        responses
      end

      ##
      # Make the model serializeable by ActiveModelSerializer
      #
      # @return [OpenStruct]
      #
      def self.model_name
        OpenStruct.new(name: "Qualtrics::API::ResponseExport",
                       klass: self,
                       singular: "qualtrics_response_export",
                       plural: "qualtrics_response_exports",
                       element: "response_exports",
                       human: "response_export",
                       collection: "qualtrics/response_exports",
                       param_key: "qualtrics_response_exports",
                       i18n_key: "qualtrics/response_exports",
                       route_key: "qualtrics_response_exports",
                       singular_route_key: "qualtrics_response_export")
      end
  end
end
