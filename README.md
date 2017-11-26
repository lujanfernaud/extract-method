# Upcase Refactoring Trail

## Extract Method

Refactoring exercise using the [Extract Method](https://refactoring.com/catalog/extractMethod.html) refactoring for the [Upcase Refactoring Trail](https://thoughtbot.com/upcase/refactoring).

### Extract Method

> Turn the fragment into a method whose name explains the purpose of the method. -- Martin Fowler

#### Before

```ruby
class ReceiptPrinter
  COST = {
    'meat' => 5,
    'milk' => 3,
    'candy' => 1,
  }

  TAX = 0.05

  def initialize(output: $stdout, items:)
    @output = output
    @items = items
  end

  def print
    subtotal = items.reduce(0) do |sum, item|
      item_cost = COST[item]
      output.puts "#{item}: #{sprintf('$%.2f', item_cost)}"

      sum + item_cost.to_i
    end

    output.puts divider
    output.puts "subtotal: #{sprintf('$%.2f', subtotal)}"
    output.puts "tax: #{sprintf('$%.2f', subtotal * TAX)}"
    output.puts divider
    output.puts "total: #{sprintf('$%.2f', subtotal + (subtotal * TAX))}"
  end

  private

  attr_reader :output, :items

  def divider
    '-' * 13
  end
end
```

#### After

```ruby
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
    items.each { |item| print_output_for item, cost(item) }
  end

  def print_output_for(item, amount = send(item))
    output.puts "#{item}: #{format_output_for amount}"
  end

  def format_output_for(item)
    currency_format = "$%.2f"
    format(currency_format, item)
  end

  def cost(item)
    COST[item].to_i
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
    items.reduce(0) { |sum, item| sum + cost(item) }
  end

  def tax
    subtotal * TAX
  end

  def total
    subtotal + (subtotal * TAX)
  end
end
```
