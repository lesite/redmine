require 'redmine'
module WikiExtensionsHelper
  #This needed to define WikiExtensionsHelper for WikiExtensionsController.
end
module ActionView  
  module Helpers
    module WikiExtensionsHelper  
     
     
      ## Method for displaying tree of comments\n
      #comments_tree - is orderly array of comments;
      #parent_id - is id of parent comment;
      #k - is number of tree nodes;\n
      #page - is wiki_page object;
      #data - is wiki_extensions_data on this page
      def display_comments_tree(comments_tree, parent_id,page,data,k = 0)
        ret = '<ul style="padding-left:20px;">'
        k += 1
        if k < 26 #maximum number of tree nodes is 25
          comments_tree.each do |comment|
            if comment.parent_id == parent_id
        
              div_comment_id = "wikiextensions_comment_#{comment.id}"
              li_comment_id = "wikiextensions_comment_li_#{comment.id}"
              form_reply_id = "wikiextensions_reply_form_#{comment.id}"
              form_div_id = "wikiextensions_comment_form_#{comment.id}"

              ret << '<li id='+li_comment_id+'>'
              ret << "<div>"
              ret << '<div class="contextual">'

              reply_link = link_to_function(l(:button_reply), "$('#{form_reply_id}').show();", :class => 'icon icon-comment')
              ret << reply_link if User.current.allowed_to?({:controller => 'wiki_extensions', :action => 'reply_comment'}, @project)

              if User.current.admin or User.current.id == comment.user.id
                edit_link = link_to_function(l(:button_edit), "$('#{div_comment_id}').hide();$('#{form_div_id}').show();", :class => 'icon icon-edit')
                ret << edit_link if User.current.allowed_to?({:controller => 'wiki_extensions', :action => 'update_comment'}, @project)
          
                del_link =  link_to_if_authorized(l(:button_delete), {:controller => 'wiki_extensions',
                    :action => 'destroy_comment', :id => @project, :comment_id => comment.id},
                  :class => "icon icon-del", :confirm => l(:text_are_you_sure))
                ret << del_link if del_link
              end
          
              ret << "\n"
              ret << "</div>\n"
              ret << "<h3>"
        
              if l(:this_is_gloc_lib) == 'this_is_gloc_lib'
                ret << l(:label_added_time_by, comment.user, distance_of_time_in_words(Time.now,comment.updated_at))
              else
                ret << l(:label_added_time_by, :author => comment.user, :age => distance_of_time_in_words(Time.now, comment.updated_at))
              end
              ret << "</h3>\n"
              ret << '<div id="' + div_comment_id + '">' + "\n"
              ret << textilizable(comment, :comment)
              ret << "</div>\n"
        
              ret << '<div id="' + form_div_id + '" style="display:none;">' + "\n"

              url = url_for(:controller => 'wiki_extensions', :action => 'update_comment', :id => @project)
        
              ret << '<form method="post" action="' + url + '">'
              if protect_against_forgery?
                ret << hidden_field_tag(:authenticity_token, form_authenticity_token)
                ret << "\n"
              end
              ret << "\n"
              ret << hidden_field_tag(:comment_id, comment.id)
              ret << "\n"
              textarea_id = "wiki_extensions_comment_edit_area_#{comment.id}"
              ret << text_area_tag(:comment, comment.comment, :rows => 5, :cols => 70, :id => textarea_id,:accesskey => accesskey(:edit),
                :class => 'wiki-edit')
              ret << '<br/>'
              ret << submit_tag(l(:button_apply))
              ret << link_to_function(l(:button_cancel), "$('#{div_comment_id}').show();$('#{form_div_id}').hide();")
              ret << "\n"
              ret << wikitoolbar_for(textarea_id)
              ret << '</form>'

              ret << '</div>'
        
              ret << '<div id="' + form_reply_id + '" style="display:none;">' + "\n"
              url = url_for(:controller => 'wiki_extensions', :action => 'reply_comment', :id => @project)
        
              ret << '<form method="post" action="' + url + '">'
              if protect_against_forgery?
                ret << hidden_field_tag(:authenticity_token, form_authenticity_token)
                ret << "\n"
              end
              ret << "\n"
              ret << hidden_field_tag(:comment_id, comment.id)
              ret << hidden_field_tag(:wiki_page_id, page.id)
              ret << "\n"
              textarea_id = "wiki_extensions_comment_reply_area_#{comment.id}"
              ret << text_area_tag(:reply,'', :rows => 5, :cols => 70, :id => textarea_id, :accesskey => accesskey(:edit),
                :class => 'wiki-edit')
              ret << '<br/>'
              ret << submit_tag(l(:button_reply))
              ret << link_to_function(l(:button_cancel), "$('#{form_reply_id}').hide();")
              ret << "\n"
              ret << wikitoolbar_for(textarea_id)
              ret << '</form>'
              ret << '</div>'
        
              ret << "</div>"
        
              ret << display_comments_tree(comments_tree, comment.id,page,data,k) unless comment.children(comments_tree).empty?
              ret << "\t</li>\n"
            end
          end
        end
        ret << "</ul>\n"
        return ret
      end
    end
  end
end
