module Jekyll
  module Tags
    class Picture < Liquid::Tag
      #ExtraClasses = /(\S+(\s+\S+){0,})/i

      def initialize(tag, attrs, tokens)
        super

        attributes_list = attrs.split(',')

        @src = ''
        @alt = ''

        attributes_list.each do |attribute|
          if attribute.include? 'src:'
            @src = attribute.sub(/^src: /, '')
          elsif attribute.include? 'alt:'
            @alt = attribute.sub(/^alt: /, '')
          end
        end
      end

      def render(context)
        @config = context.registers[:site].config['imgix']
        @rel_path = context.registers[:page]['categories'].join("/") + "/" + context.registers[:page]['name'] + "/"
        @url = "#{@config['main_images']}#{@rel_path}#{@src}"

        img = "<img data-src=\"#{@url}.jpg\" alt=\"#{@alt}\" class=\"imgix-fluid\"/>"
        img << "<noscript><img src=\"#{@url}.jpg\" alt=\"#{@alt}\" /></noscript>"
      end
    end
  end
end

Liquid::Template.register_tag('picture', Jekyll::Tags::Picture)
