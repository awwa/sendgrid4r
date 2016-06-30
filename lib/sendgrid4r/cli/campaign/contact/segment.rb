module SendGrid4r::CLI
  module Campaign
    module Contact
      #
      # SendGrid Web API v3 Marketing Campaigns - Segment
      #
      class Segment < SgThor
        def initialize(*args)
          super
          @condition_factory = SendGrid4r::Factory::ConditionFactory.new
          @segment_factory = SendGrid4r::Factory::SegmentFactory.new
        end

        desc 'create', 'Create a segment'
        option :name, require: true
        option :list_id, type: :numeric, require: true
        option(
          :conditions,
          type: :array,
          require: true,
          banner: 'field:email,value:abc@abc.abc,operator:eq,and_or:'
        )
        def create
          conditions = options[:conditions].map do |c|
            array = c.delete(' ').split(/[:,]/)
            hash = array.each_slice(2).map do |k, v|
              [k.to_sym, v.nil? ? '' : v]
            end.to_h
            @condition_factory.create(hash)
          end
          params = @segment_factory.create(
            name: options[:name],
            list_id: options[:list_id],
            conditions: conditions
          )
          puts @client.post_segment(params: params)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'list', 'List segments'
        def list
          puts @client.get_segments
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'get', 'Get a segment'
        option :segment_id, require: true
        def get
          puts @client.get_segment(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'update', 'Update a segment'
        option :segment_id, require: true
        option :name
        option(
          :conditions,
          type: :array,
          banner: 'field:email,value:abc@abc.abc,operator:eq,and_or:'
        )
        def update
          conditions = options[:conditions].map do |c|
            array = c.delete(' ').split(/[:,]/)
            hash = array.each_slice(2).map do |k, v|
              [k.to_sym, v.nil? ? '' : v]
            end.to_h
            @condition_factory.create(hash)
          end
          params = @segment_factory.create(
            name: options[:name],
            conditions: conditions
          )
          puts @client.patch_segment(
            segment_id: options[:segment_id],
            params: params
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'delete', 'Delete a segment'
        option :segment_id, require: true
        def delete
          puts @client.delete_segment(parameterise(options))
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
        end

        desc 'recipient [list]', 'List recipients'
        option :segment_id, require: true
        def recipient(action)
          case action
          when 'list'
            puts @client.get_recipients_on_segment(parameterise(options))
          else
            puts "error: #{action} is not supported in action parameter"
          end
        end
      end
    end
  end
end
