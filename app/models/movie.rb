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


  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def self.search(terms, duration)

    #@movies.where("title IN (?) OR director IN (?)", ["Spy", "%Don%"], ["Spy", "%Don%"])

    return @movies = Movie.all if terms.empty? && duration.empty?

    @movies = Movie.all

    terms.split(' ').each do |term|
      @movies = @movies.where("title LIKE ? or director LIKE ?", "%#{term}%", "%#{term}%")
    end

    @movies = Movie.where(@movies.where_values.join(" OR "))

    if duration
      case duration
      when "Under 90"
        @movies = @movies.where("runtime_in_minutes < 90")
      when "Between 90 and 120"
        @movies = @movies.where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120")
      when  "Over 120"
        @movies = @movies.where("runtime_in_minutes > 120")
      end
    end

    @movies

  end

end
