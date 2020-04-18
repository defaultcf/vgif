module TagList
  extend ActiveSupport::Concern

  def tag_list=(tag_json)
    begin
      arr = JSON.parse(tag_json).pluck('value')
    rescue
      arr = []
    end

    super(arr)
  end
end
