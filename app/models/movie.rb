class Movie < ActiveRecord::Base

  mount_uploader :image_path, AvatarUploader

  has_many :reviews
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  def self.review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end


  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

   scope :search_movies, lambda { |search| where('title LIKE ? OR director LIKE ?', "%#{search}%", "%#{search}%") }

  def self.movie_length(time)
    case time
    when "short"
      where('runtime_in_minutes < 90') 
    when "med"
      where('runtime_in_minutes >= 90 and runtime_in_minutes < 120')
    when "long"
      where('runtime_in_minutes >= 120')
    else
      all
    end
  end

end
