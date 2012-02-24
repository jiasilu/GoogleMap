class GMap < ActiveRecord::Base
  acts_as_gmappable
  belongs_to :user
  
  #************GoogleMap*****************
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  #  "#{self.street}, #{self.city}, #{self.country}" 
    address
  end
  
  def gmaps4rails_infowindow
    # add here whatever html content you desire, it will be displayed when users clicks on the marker
    "#{user.username}"
  end
  
  def gmaps4rails_title
    # add here whatever text you desire
    "#{user.username}"
  end
  
  # creat a list of markers in html
  def gmaps4rails_sidebar
    "<span class='foo'>#{address}</span>" #put whatever you want here
  end
  
  def gmaps4rails_marker_picture
    {
     "picture" => "/images/beachflag.png",
     "width" => "20",
     "height" => "32",
     "marker_anchor" => [ 5, 10],
    }
  end
end
