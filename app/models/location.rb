class Location < ActiveRecord::Base

  has_many :users

  scope :hot, -> { desc(:users_count) }

  validates :name, uniqueness: { case_sensitive: false }

  def self.find_by_name(name)
    return nil if name.blank?
    name = name.downcase.strip
    query = !name.match(/\p{Han}/).nil? ? name : /#{name}/i
    where(name: query).first
  end

  def self.find_or_create_by_name(name)
    unless (location = find_by_name(name))
      location = create(name: name.strip)
    end
    location
  end
end
