class GildedRose
  def initialize(items)
    @items = items
    @names = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Sulfuras, Hand of Ragnaros', 'Conjured']

    @normal_unit = 1
    @max_quality = 50
    @min_quality = 0
    @sell_in_10 = 10
    @sell_in_5 = 5
  end

  def update_quality
    @items.each do |item|
      next if next_item?(item)

      update_quality_nomal_sell_in item
      item.sell_in -= @normal_unit
      update_quality_negative_sell_in item
    end
  end

  private

  def next_item?(item)
    # Item quality alway > 0 and Sulfuras, being a legendary item,
    # The quality of an item is never more than 50
    # has no sell by date nor decreases in quality
    item.quality <= @min_quality || item.quality >= @max_quality || item.name == @names[2]
  end

  def update_quality_nomal_sell_in(item)
    if @names[0..1].include?(item.name)
      item.quality += @normal_unit
      if item.name == @names[1]
        item.quality += @normal_unit if item.sell_in <= @sell_in_10
        item.quality += @normal_unit if item.sell_in <= @sell_in_5
      end
    else
      item.quality -= @normal_unit
    end
  end

  def update_quality_negative_sell_in(item)
    if item.sell_in.negative? # is mean item.sell_in < 0
      if item.name == @names[0]
        item.quality += @normal_unit
      elsif item.name == @names[1]
        item.quality = @min_quality
      elsif item.name == @names[3]
        # Conjured items degrade in quality twice as fast as normal items
        item.quality -= @normal_unit * 2
      else
        item.quality -= @normal_unit
      end
    end
  end
end
