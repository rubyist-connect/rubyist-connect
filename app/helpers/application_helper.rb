module ApplicationHelper
  # http://qiita.com/ppworks/items/9bf917edf0d4927b15bd
  def link_to_if_with_block(condition, options = nil, html_options = nil, &block)
    if condition
      link_to(options, html_options, &block)
    else
      capture(&block)
    end
  end

  def display_age(user)
    return if user.try(:age).blank?
    "#{user.age}歳"
  end

  def markdown_to_html(text)
    markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, xhtml: true),
                                        autolink: true,
                                        space_after_headers: true,
                                        no_intra_emphasis: true,
                                        fenced_code_blocks: true,
                                        tables: true,
                                        lax_html_blocks: true,
                                        strikethrough: true

    markdown.render(text).html_safe unless text.blank?
  end

  def display_title(page_title)
      content_for(:title) do
          page_title
      end
     content_tag :h1, page_title
  end
end
