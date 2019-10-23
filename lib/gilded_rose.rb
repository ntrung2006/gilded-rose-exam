class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # Item quality alway > 0 and Sulfuras, being a legendary item,
      # The quality of an item is never more than 50
      # has no sell by date nor decreases in quality
      next if item.quality <= 0 || item.quality >= 50 || item.name == 'Sulfuras, Hand of Ragnaros'

      if ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert'].include?(item.name)
        item.quality += 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality += 1 if item.sell_in < 11
          item.quality += 1 if item.sell_in < 6
        end
      else
        item.quality -= 1
      end

      item.sell_in -= 1

      if item.sell_in.negative? #is mean item.sell_in < 0
        if item.name == 'Aged Brie'
          item.quality += 1
        elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = 0
        elsif item.name == 'Conjured'
          item.quality -= 2
        else
          item.quality -= 1
        end
      end
    end
  end
end
