module ApplicationHelper
    def render_stars(value)
        output = ''
        if (1..5).include?(value.floor)
          value.floor.times { output += image_tag('star-on.png')}
        end
        if value == (value.floor + 0.5) && value.to_i != 5
          output += image_tag('star-half.png')
        end
        output.html_safe
      end
end
