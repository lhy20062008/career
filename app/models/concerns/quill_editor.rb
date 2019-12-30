module QuillEditor
  extend ActiveSupport::Concern
  def save_images
    Dir.mkdir "#{Rails.root}/tmp/quills/" unless Dir.exists? "#{Rails.root}/tmp/quills/"
    html = Nokogiri::HTML self.send(quill_field)
    images = html.css('img')
    now = Time.now.to_i
    images && images.each_with_index do |x, index|

      src = x['src']
      if src =~ /base64/
        data = src.split(",", 2).last
        ext = src.split(",", 2).first.split(";")[0].split(":")[1].split("/")[1] rescue 'jpg'
        file = File.open("#{Rails.root}/tmp/quills/#{now}_#{index}.#{ext}", 'w+b')
        file.write Base64.decode64(data)
        image = Image.new image: file
        image.save
        file.close
        `rm "#{Rails.root}/tmp/quills/#{now}_#{index}.jpeg"`
        x['src'] = image.image.url if image.persisted?
      end
      x['style'] = "max-width: 100%; min-width: 100%; padding-top: 8px !important; padding-bottom: 8px !important;"
    end
    html = html.css('body').try(:inner_html) || html.to_html
    html.gsub!("\n", "")
    self.send("#{quill_field}=", html)
  end

  class_methods do

    def quill_options
      {
        modules: {
          toolbar: [
            ['bold', 'italic', 'underline', 'strike', 'image'], 
            [{'color': ["", "#e60000", "#ff9900", "#ffff00", "#008a00", "#0066cc", "#9933ff", "#ffffff", "#facccc", "#ffebcc", "#ffffcc", "#cce8cc", "#cce0f5", "#ebd6ff", "#bbbbbb", "#f06666", "#ffc266", "#ffff66", "#66b966", "#66a3e0", "#c285ff", "#888888", "#a10000", "#b26b00", "#b2b200", "#006100", "#0047b2", "#6b24b2", "#444444", "#5c0000", "#663d00", "#666600", "#003700", "#002966", "#3d1466"]}],
            ['blockquote', 'code-block'],
            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
            [{ 'indent': '-1'}, { 'indent': '+1' }],         
            [{ 'direction': 'rtl' }],                         
            # [{ 'size': ['small', false, 'large', 'huge'] }],  
            # [{ 'font': [] }],
            [{ 'header': [3, 4, false] }],
            # [{ 'align': [] }],
          ]
        }, 
        placeholder: 'Type something...', 
        theme: 'snow'
      }
    end
  end
end