module Attachmentable
  extend ActiveSupport::Concern
  included do
    before_save do
      if file.file_name.present?
        self.name = file.file_name
        self.size = file.size
        self.ext = self.name.split(".").last
      end
    end
  end

  def human_size
    if size < 1024
      "#{size}B"
    elsif size < 1024 * 1024
      "#{(size / 1024.to_f).round(2)}KB"
    elsif size < 1024 * 1024 * 1024
      "#{(size / (1024 * 1024).to_f).round(2)}M"
    end 
  end

  def file_type
    if %w(doc docx).include?(ext)
      'word'
    elsif %w(xls xlsx).include?(ext)
      'excel'
    elsif %w(ppt pptx).include?(ext)
      'powerpoint'
    elsif %w(pdf csv).include?(ext)
      ext
    elsif ext == 'zip'
      'archive'
    else
      'alt'
    end
  end
end