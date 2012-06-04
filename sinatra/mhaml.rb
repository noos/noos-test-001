require 'pp'

module Sinatra
  module Mhaml
    """
      what we have now:
        - init script
          = jqm_cdn_init
          = jqm_local_init

        - tags
          = page
          = header (!=head)
          = content
          = footer
          = button
          = listview
          = list_divider
          = lia
            ! don't use 'liab'
            ** use nested 'a' inside 'lia' for split buttons
          = toolbar
            ! don't use 'navbar'
            * this encapsulated 'navbar'
          = li
            this automatically injects ul for nested list
            * cannot be used with nested tags
              which means 'img' tags
              to use 'img' inside li use %li
          = a
            * for easier syntax
            ** use nested 'a' inside 'lia' for split buttons
          = collapsible
          = collapsible_set
          = controlgroup


        - templating
          = kontent_for
          = kontent

        TODO
          columns

          listview with
            icon
              * as attrib
            thumnail
            aside
            count
            filter

          fieldcontainer

          input
            * auto label
            text
            password
            email
            tel
            url
            search
            number
            textarea

            date
            datetime
            time
            datetime-local
            month
            week

            range

            radio
            checkbox

          select
          option
          legend

          fix toolbar when href is externam
            soln
              parse url and use the hash part

        TIP
          store templates on layout

    """

    def jqm_cdn_init
      temp = capture_haml do
        yield if block_given?
      end
        #'<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">',
        # '<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />',
      [
        '<meta charset="utf-8" />',
        '<link rel="stylesheet" href="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.css" />',
        '<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>',
        temp.strip,
        '<script src="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.js"></script>',
        '<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">',
        '<meta name="apple-mobile-web-app-capable" content="yes" />'
      ].join("\n")
    end

    def jqm_local_init
      temp = capture_haml do
        yield if block_given?
      end
        #'<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">',
        # '<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />',
      [
        '<meta charset="utf-8" />',
        '<link href="/css/jquery.mobile-1.1.0.css" rel="stylesheet" />',
        '<script src="/js/jquery.js"></script>',
        temp.strip,
        '<script src="/js/jquery.mobile-1.1.0.js"></script>',
        '<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">',
        '<meta name="apple-mobile-web-app-capable" content="yes" />'
      ].join("\n")
    end

    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    # trying to use local
    # and pass to nested blocks
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

    #def kontent_for(key, *args, &block)
    #def kontent_for(key, locals={}, subs={}, &block)
    
    
    def kontent_for(key, &block)
      @content ||= {}
      #@content[key] = {:args => args, :block => block}
      #@content[key] = {:locals => locals, :subs => subs, :block => block}
      @content[key] = {:block => block}
    end

    def kontent_fill(key, locals={}, subs={}, &nested_block)
      #pass
      #@content[key] = {:locals => locals, :subs => subs, :block => block}
      pp ""
      pp ""
      pp "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp "kontent_fill!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp "key!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp key
      pp "subs!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp subs
      @content[key] ||= {}
      @content[key][:subs] = subs
      pp "content!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      pp @content
      
      ################
      haml_concat kontent(key, locals, subs, &nested_block)
      ################
    end

    def kontent(key, locals={}, subs={}, &nested_block)
      if defined? @content then
        if block_given? then
          capture_haml(locals, subs, &nested_block)
        end
        
        pp ""
        pp ""
        pp "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp "kontent!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp "key!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp key
        pp "subs!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp subs
        #block = @content[key][:block] ||
        #  @content[key][subs[:block]]
        #block = @content[key][:block]
        #black = @content[subs[key]][:block]
        
        block =
          if subs.has_key?(key) then
            @content[subs[key]][:block]
          else
            @content[key][:block]
          end
        pp "content!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp @content
        pp "block!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        pp block
        capture_haml(locals, subs, &block)
      end
    end























    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

    def partial(page, options={}, &block)
      """
        views/temp.haml
        =partial :temp, :locals => {:page_id => 'test1'}
      """
      haml page, options.merge!(:layout => false)
    end

    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

    def to_jqm_attributes(src)

      def jqm(attr)
        """
        does two things:
          1. prefixes all attributes with 'data-' unless reserved attribute
          2. convertes all '_' to '-'
        """
        jqm = %w{add_back_btn rel overlay_theme transition fullscreen position icon theme}
        reserved = %w{id class style href onclick html}

        attr = attr.to_s.gsub('_', '-')

        return attr.to_sym if reserved.member?(attr) || /^data/.match(attr)
        return ("data-" + attr).to_sym 
        #return ("data-" + attr.to_s.gsub('_','-')).to_sym 
        #reserved.member?(attr.to_s) ? attr : ("data-" + attr.to_s.gsub('_','-')).to_sym
      end

      Hash[src.map{|k,v| [jqm(k),v] unless k.to_s == "html"}]
    end


    %w{page header content footer navbar collapsible collapsible_set controlgroup}.each do |w|
      define_method w do |*attrs, &block|
        attrs = attrs.first
        attrs ||= {}
        w = w.to_s.gsub('_', '-')
        capture_haml do
          haml_tag "div", to_jqm_attributes(attrs).merge({:"data-role" => w}) do
            # capture_haml(&block)
            # puts capture_haml(&block)
            # capture_haml(&block).to_s
            haml_concat attrs[:html] if attrs.has_key?(:html)
            block.call if block
            #attrs[:html] if attrs.has_key?(:html)
            #haml_content(attrs[:html]) if attrs.has_key?(:html)
          end
        end
      end
    end

    
    def button(attrs={},&block)
      capture_haml do
        haml_tag "a", to_jqm_attributes(attrs).merge({:"data-role" => "button"}) do
          haml_concat attrs[:html] if attrs.has_key?(:html)
          block.call if block
        end
      end
    end

    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

    def listview(attrs={},&block)
      capture_haml do
        haml_tag "ul", to_jqm_attributes(attrs).merge({:"data-role" => "listview"}) do
          haml_concat attrs[:html] if attrs.has_key?(:html)
          block.call if block
        end
      end
    end

    def list_divider(attrs={},&block)
      capture_haml do
        haml_tag "li", to_jqm_attributes(attrs).merge({:"data-role" => "list-divider"}) do
          haml_concat attrs[:html] if attrs.has_key?(:html)
          block.call if block
        end
      end
    end

    def lia(attrs={},&block)
      """
        use mostly in listview
        * using attrib in both 'li' and 'a' tag
          not a good idea
      """
      capture_haml do
        #haml_tag "li" do
        haml_tag "li", to_jqm_attributes(attrs) do
          haml_tag "a", to_jqm_attributes(attrs) do
            haml_concat attrs[:html] if attrs.has_key?(:html)
            block.call if block
          end
        end
      end
    end

    def a(attrs={},&block)
      """
        use inside lia for split list
      """
      capture_haml do
        haml_tag "a", to_jqm_attributes(attrs) do
          haml_concat attrs[:html] if attrs.has_key?(:html)
          block.call if block
        end
      end
    end

    def li(attrs={},&block)
      """
        automatically injects ul.listview tag
        for nested lists
        * even non 'li' tags get wrapped in ul.listview
          not a good idea
          esp for nesting img
      """
      capture_haml do
        haml_tag "li", to_jqm_attributes(attrs) do
          haml_concat attrs[:html] if attrs.has_key?(:html)
          haml_concat listview(&block) if block
        end
      end
    end

    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 


    def toolbar(active, menus)
      ################
      active ||= "home"
      ################
      capture_haml do
        haml_tag "div", {:"data-role" => "navbar"} do
          haml_tag "ul" do
            menus.each do |menu|
              menu.merge!({:class => "ui-btn-active ui-state-persist"}) if menu[:href]=="#"+active
              haml_concat lia(menu)
            end
          end
        end
      end
    end



    helpers Mhaml
  end
end

