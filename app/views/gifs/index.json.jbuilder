# frozen_string_literal: true

json.array! @gifs, partial: 'gifs/gif', as: :gif
