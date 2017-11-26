class ReceiptPrinter
  COST = {
    "meat"  => 5,
    "milk"  => 3,
    "candy" => 1
  }.freeze

  TAX = 0.05
  RECEIPT_WIDTH = 13

  def initialize(output: $stdout, items:)
    @output = output
    @items  = items
  end

  def print
    print_items
    print_receipt
  end

  private

  attr_reader :output, :items

  def print_items
    items.each { |item| print_output_for item, COST[item] }
  end

  def print_output_for(item, amount = send(item))
    output.puts "#{item}: #{format_output_for amount}"
  end

  def format_output_for(amount)
    currency_format = "$%.2f"
    format(currency_format, amount)
  end

  def print_receipt
    print_divider
    print_output_for :subtotal
    print_output_for :tax
    print_divider
    print_output_for :total
  end

  def print_divider
    output.puts "-" * RECEIPT_WIDTH
  end

  def subtotal
    items.reduce(0) { |sum, item| sum + COST[item] }
  end

  def tax
    subtotal * TAX
  end

  def total
    subtotal + (subtotal * TAX)
  end
end
