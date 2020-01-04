require "ruby2d"

module View
  class Ruby2dView

    def initialize(app)
      @pixel_size = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows)
      on :key_down do |event|
        # A key was pressed
        handle_key_event(event)
      end
      show
    end

    def render(state)
      render_food(state)
      render_snake(state)
    end

    private

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food
      @food = Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions
      extend Ruby2D::DSL
      snake = state.snake
      @snake_positions = snake.positions.map do |pos|
        Square.new(
          x: pos.col * @pixel_size,
          y: pos.row * @pixel_size,
          size: @pixel_size,
          color: 'green'
        )
      end
    end

    def handle_key_event(event)
      case event.key
      when "up"
        @app.send_action(:change_direction,  Model::Direction::UP)
      when "right"
        @app.send_action(:change_direction,  Model::Direction::RIGHT)
      when "down"
        @app.send_action(:change_direction,  Model::Direction::DOWN)
      when "left"
        @app.send_action(:change_direction,  Model::Direction::LEFT)
      end
    end
  end
end