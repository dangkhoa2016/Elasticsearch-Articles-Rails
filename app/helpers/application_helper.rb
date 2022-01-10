module ApplicationHelper
  def menu_item(resource_name)
    classes = ['nav-item']
    classes << 'active' if resource_name == controller_name
    content_tag :div, class: classes.join(' ') do
      content_tag(:a, href: "/#{resource_name}", class: 'nav-link') do
        resource_name.titleize
      end
    end
  end

  def es_version
    Article.es_version
  end

  def search_method_options
    [
      ['Match', 'best_fields'],
      ['Match phrase', 'phrase'],
      ['Match phrase prefix', 'phrase_prefix'],
    ]
  end
end
