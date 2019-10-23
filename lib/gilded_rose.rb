class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    normal_unit = 1 # Unit normal increases | degrade
    max_quality = 50
    min_quality = 0
    sell_in_10 = 10
    sell_in_5 = 5
    @items.each do |item|
      # Item quality alway > 0 and Sulfuras, being a legendary item,
      # The quality of an item is never more than 50
      # has no sell by date nor decreases in quality
      next if item.quality <= min_quality || item.quality >= max_quality || item.name == 'Sulfuras, Hand of Ragnaros'

      if ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert'].include?(item.name)
        item.quality += normal_unit
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality += normal_unit if item.sell_in <= sell_in_10
          item.quality += normal_unit if item.sell_in <= sell_in_5
        end
      else
        item.quality -= normal_unit
      end

      item.sell_in -= normal_unit

      if item.sell_in.negative? #is mean item.sell_in < 0
        if item.name == 'Aged Brie'
          item.quality += normal_unit
        elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = min_quality
        elsif item.name == 'Conjured'
          # Conjured items degrade in quality twice as fast as normal items
          item.quality -= normal_unit*2
        else
          item.quality -= normal_unit
        end
      end
    end
  end
end
