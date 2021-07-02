class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_created_at
    time_format = "%P %l:%M - %Y年%-m月%-d日"
    create_format = self.created_at.strftime(time_format)
    create_format.gsub!(/am/, '午前')
    create_format.gsub!(/pm/, '午後')
    return create_format
  end

  def get_private
    if !!self.private
      return "非公開設定中"
    else
      return "公開中"
    end
  end
  
end
