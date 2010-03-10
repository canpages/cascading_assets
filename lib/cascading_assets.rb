# CascadingAssets

module ActionView::Helpers::AssetTagHelper
  private
  def expand_javascript_sources_with_cascade(sources, recursive = false)
    expand_cascading_sources(sources, ActionView::Helpers::AssetTagHelper::JAVASCRIPTS_DIR, "js")
    expand_javascript_sources_without_cascade(sources, recursive)
  end
  alias_method_chain :expand_javascript_sources, :cascade

  def expand_stylesheet_sources_with_cascade(sources, recursive = false)
    expand_cascading_sources(sources, ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, "css")
    expand_stylesheet_sources_without_cascade(sources, recursive)
  end
  alias_method_chain :expand_stylesheet_sources, :cascade

  def expand_cascading_sources(sources, dir, extension)
    if sources.delete(:cascades)
      ['application', @controller.active_layout.try(:name), @controller.controller_name, "#{@controller.controller_name}/#{@controller.action_name}"].compact.uniq.each do |source|
        sources << source if File.exists?(File.join(dir, "#{source}.#{extension}"))
      end
    end
  end
end
