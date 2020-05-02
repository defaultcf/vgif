# frozen_string_literal: true

module TagList
  extend ActiveSupport::Concern

  def tag_list=(tag_json)
    begin
      arr = JSON.parse(tag_json).pluck('value')
    rescue StandardError
      arr = []
    end

    super(arr)
  end
end
