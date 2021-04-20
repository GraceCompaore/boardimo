require "json"
require "tilt"
require "erb"

require "./lib/board_imo"
require "./lib/house"

class Controller
  attr_accessor :params

  def index
    @list = House::all

    render({list: @list})
  end

  def analyse
    @houses = House::all

    render_json({ houses: @houses })
  end

  def clear
    board.clear

    redirect("/")
  end

  def not_found
    render({}, 404)
  end

  private

  def board
    @board ||= Board.new
  end

  def render(params, code=200)
    file = caller_locations(1,1)[0].label
    template = Tilt.new("./lib/views/#{file}.html.erb")

    [
      code, 
      {"Content-Type" => "text/html"}, 
      template.render(
        self, 
        params
      )
    ]  
  end

  def render_json(params, code=200)
    [
      code, 
      {"Content-Type" => "application/json"}, 
      [params.to_json]
    ]  
  end

  def redirect(to)
    [302, {'Location' => to}, []]
  end
end
