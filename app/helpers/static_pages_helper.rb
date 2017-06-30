module StaticPagesHelper
  def full_title(main_title='')
    base_title = 'Pithugram'
    if main_title.empty?
      base_title
    else
      "#{main_title}|#{base_title}"
    end
  end
end
