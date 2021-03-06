module ApplicationHelper

  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  def gravatar_for(user, size = 30, title = user.email)
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
  end

  def default_header_image
    image_tag 'header_img_default.png', class: "img-responsive"
  end

  def default_logo_image
    image_tag 'profile_pic_default.png'
  end

end
