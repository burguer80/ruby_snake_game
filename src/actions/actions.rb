module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)

    if next_position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end
  end

  private

  def calc_next_position(state)
    curr_position = state.snake.positions.first
    case state.next_direction
    when UP
      # decrease row
      return Model::Coord.new(
        curr_position.row - 1,
        curr_position.col)
    when RIGHT
      # increase col
      return Model::Coord.new(
        curr_position.row,
        curr_position.col + 1)
    when DOWN
      # increase row
      return Model::Coord.new(
        curr_position.row + 1,
        curr_position.col)
    when LEFT
      # decrease col
       return Model::Coord.new(
            curr_position.row,
            curr_position.col - 1)
    end
  end

end