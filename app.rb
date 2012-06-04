require 'sinatra'
require 'sinatra/mhaml'

get '/' do
  haml :index
end
__END__
@@index
!!!5
%html
  %head
    =jqm_local_init do
      :javascript
        $(document).bind('mobileinit',function(){
        
          $.mobile.touchOverflowEnabled = true;

          $(':jqmData(url^=nlist)').live('pagebeforecreate', 
            function(event) {
              $(this).filter(':jqmData(url*=ui-page)').find(':jqmData(role=header)')
                .prepend('<a href="#" data-rel="back" data-icon="back">Back</a>')
            });
        });
    %title Using mHaml
  %body


    -kontent_for :kt_header_log_set do |locals, subs|
      =button :href => "logout", :html => "Logout"
      %h1 SPREAD
      =button :href => "settings", :icon => "gear", :theme => "b", :html => "Settings"
      =toolbar locals[:page_id],                                          |
        [ {:icon => "home",   :href => "#home",     :html => "Home"},     |
          {:icon => "search", :href => "#contacts", :html => "Contacts"}, |
          {:icon => "info",   :href => "#events",   :html => "Events"},   |
          {:icon => "grid",   :href => "#nlist",    :html => "News"}      ]


    -kontent_for :kt_footer_navbar do |locals, subs|
      =toolbar locals[:page_id],                                  |
        [ {:icon => "home",  :href => "#home",  :html => "Home"}, |
          {:icon => "alert", :href => "#help",  :html => "Help"}, |
          {:icon => "grid",  :href => "#nlist", :html => "List"}  ]


    -kontent_for :kt_page_full_fixed do |locals, subs|
      =page :id => locals[:page_id], :fullscreen => "true" do
        =header :position => "__fixed__" do
          =kontent :kt_header, locals, subs
        =content do
          =kontent :kt_content, locals, subs
        =footer :position => "fixed", :data_id => "footer_navbar" do
          =kontent :kt_footer, locals, subs


    -kontent_for :kt_page_full_fixed___partial_filled do |locals, subs|
      -kontent_fill :kt_page_full_fixed,    |
        { },                                |
        { :kt_header => :kt_header_log_set, |
          :kt_content => :kt_content,       |
          :kt_footer => :kt_footer_navbar   }


    -kontent_for :page___home do |locals, subs|
      =kontent :kt_page_full_fixed___partial_filled,  |
        { :page_id => "home"},                        |
        { } do
        -kontent_for :kt_content do |locals, subs|
          =button :href => "#book", :html => "book", :transition => "slide"
          =button :href => "#page3", :rel => "dialog", :transition => "pop", :html => "Test Dialog"
          =button :href => "#navtest", :html => "Test Navbar"
          %p "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."


    =kontent :page___home



