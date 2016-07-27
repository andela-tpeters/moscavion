module Custom
  class Flash
    def initialize(request)
      @flash = request.flash
    end
    def notice=(msg = nil)
      @flash[:notice] = msg
    end

    def notice
      @flash[:notice] unless @flash[:notice]
    end

    def errors=(msgs = [])
      @flash[:errors] = self.class.process_msgs(msgs)
    end

    def errors
      @flash[:errors] unless @flash[:errors].nil?
    end

    def self.process_msgs(msgs)
      if msgs.is_a? Array
        msgs.map.with_index(1) { |x, index| "<li>#{index}. #{x}</li>"}
                                .join
      else
        msgs
      end
    end
  end
end