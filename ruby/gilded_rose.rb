class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        ## do nothing
      when "Aged Brie"
        increase_by = 1

        update_sell_in(item)
        increase_by += 1 if item.sell_in < 0

        item.quality = (item.quality + increase_by <= 50) \
          ? item.quality + increase_by : 50

      when "Backstage passes to a TAFKAL80ETC concert"
        if item.quality < 50
          item.quality += 1

          if item.sell_in < 11 && item.quality < 50
            item.quality += 1
          end
          if item.sell_in < 6 && item.quality < 50
            item.quality += 1
          end
        end

        update_sell_in(item)
        item.quality = 0 if item.sell_in < 0
      else
        item.quality -= 1 if item.quality > 0

        update_sell_in(item)
        if item.sell_in < 0
          if item.quality > 0
            item.quality -= 1
          end
        end
      end
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
