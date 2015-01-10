module ApplicationHelper
  # http://qiita.com/ppworks/items/9bf917edf0d4927b15bd
  def link_to_if_with_block(condition, options = nil, html_options = nil, &block)
    if condition
      link_to(options, html_options, &block)
    else
      capture(&block)
    end
  end
end
