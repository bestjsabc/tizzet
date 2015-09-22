module MenuHelper
  def menu_item_class(item, sequence)
    css = []
    css << "selected" if selected_page?(item) or descendant_page_selected?(item)
    css << "first" if sequence == 0
    css << "last" if sequence == item.shown_siblings.size
    css.join " "
  end
  def menu_dom_id(item, sequence)
    domid = "item_#{sequence}" unless item.parent_id.present? or item.title.blank?  
  end
  def skip_menu_children?(item)
    @menu_hide_children or item.parent_id.present? or (item.children.collect{|c| c if c.in_menu? }.compact).empty?
  end
  def menu_children?(item)
    not skip_menu_children?(item)
  end
end
