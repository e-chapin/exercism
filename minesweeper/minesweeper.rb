# solve a minesweeper board
# transform takes an array of strings, and returns an array of strings that is a solved version of the board
class Board

  # @param [Array<String>] rows
  # @raise Argument Error if invalid board
  def initialize(rows)
    @rows = rows
    @grid = {}
    @size_y = @rows.length
    @size_x = @rows.first&.size
    throw ArgumentError if !valid_shape? || !valid_rows?
  end

  # @return true if the input is a valid game board
  def valid_shape?
    @rows.each do |row|
      return false if row.length != @size_x
    end
    true
  end

  # @param [String] row
  # @return true the row is valid for an edge row of the board
  def valid_edge_row?(row)
    # edge rows should only have + and - characters, with + being in the corers
    row.start_with?('+') && row.end_with?('+') && row.tr('-', '') == '++'
  end

  # @param [String] row
  # @return true the row is valid for a middle row of the board
  def valid_middle_row?(row)
    # middle rows should have | on either edge, with only spaces and * in the middle
    row.start_with?('|') && row.end_with?('|') && row[1...-1].match?(/^[[:blank:]*]+$/)
  end

  # @return true if the game board contains valid rows
  def valid_rows?
    return false unless valid_edge_row?(@rows.first) || @rows.first != @rows.last
    @rows.each do |row|
      next if row == @rows.first || row == @rows.last
      return false unless valid_middle_row?(row)
    end
    true
  end

  # populate @grid with character values for each coordinate on the board
  def create_grid
    @rows.each_with_index do |row, y|
      row.each_char.with_index do |character, x|
        @grid[[x, y]] = character
      end
    end
  end

  # @param [Integer] x
  # @param [Integer] y
  # @return The number of mines adjacent to coordinates [x,y], otherwise a space character if there are zero
  def count_neighbors(x, y)
    total = 0
    neighbors = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
    neighbors.each do |offset_x, offset_y|
      total += @grid[[x + offset_x, y + offset_y]] == '*' ? 1 : 0
    end
    total.positive? ? total.to_s : ' '
  end

  # @return a solved version of the game board
  def solve_board
    # populate @grid
    create_grid
    # generate solved board
    rows = []
    (0...@size_y).each do |y|
      row = ''
      (0...@size_x).each do |x|
        character = @grid[[x, y]]
        row += character == ' ' ? count_neighbors(x, y) : character
      end
      rows.append(row)
    end
    rows
  end

  # @param [Array<String>] input
  def self.transform(rows)
    new(rows).solve_board
  end
end
