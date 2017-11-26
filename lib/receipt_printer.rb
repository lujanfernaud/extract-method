class ReceiptPrinter
  COST = {
    'meat'  => 5,
    'milk'  => 3,
    'candy' => 1
  }.freeze

  TAX = 0.05

  def initialize(output: $stdout, items:)
    @output = output
    @items  = items
  end

  def print
    calculate_subtotal
    print_receipt
  end

  private

  attr_reader :output, :items, :subtotal

  def calculate_subtotal
    @subtotal = items.reduce(0) do |sum, item|
      item_cost = COST[item]
      output.puts "#{item}: #{format_output_for item_cost}"

      sum + item_cost.to_i
    end
  end

  def format_output_for(item)
    format('$%.2f', item)
  end

  def print_receipt
    print_divider
    print_subtotal
    print_tax
    print_divider
    print_total
  end

  def print_divider
    output.puts '-' * 13
  end

  def print_subtotal
    output.puts "subtotal: #{format_output_for subtotal}"
  end

  def print_tax
    output.puts "tax: #{format_output_for tax}"
  end

  def print_total
    output.puts "total: #{format_output_for total}"
  end

  def tax
    subtotal * TAX
  end

  def total
    subtotal + (subtotal * TAX)
  end
end
