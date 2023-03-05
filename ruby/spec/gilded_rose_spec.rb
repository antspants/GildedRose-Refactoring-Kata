## require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative '../gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    describe "backstage passes" do
      let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 25, 20) }
      let(:items) { [item] }
      let(:gilded_rose) { GildedRose.new(items) }

      context "current item sell_<= 0" do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20) }

        it "initialises quality to 0" do
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

      context "current item sell_in > 10" do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 25, 20) }

        context "current quality is < 50" do
          it "increments quality by 1" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context "current quality is 50" do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 25, 50) }

          it "it does not increment quality" do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context "current item sell_in < 11" do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20) }

        it "increments quality by 2" do
          expect { gilded_rose.update_quality }
            .to change { item.quality }
            .by(2)
        end

        context "current quality is 49" do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49) }
          it "increments quality by 1" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end
      end

      context "current item sell_in < 6" do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20) }

        it "increments quality by 3" do
          expect { gilded_rose.update_quality }
            .to change { item.quality }
            .by(3)
        end

        context "current quality is 48" do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 48) }
          it "increments quality by 2" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end
      end
    end

    describe "aged brie" do
      let(:item) { Item.new('Aged Brie', 25, 20) }
      let(:items) { [item] }
      let(:gilded_rose) { GildedRose.new(items) }

      context "current item sell_in > 1" do
        let(:item) { Item.new('Aged Brie', 25, 20) }

        context "current quality is < 50" do
          it "increments quality by 1" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context "current quality equals 50" do
          let(:item) { Item.new('Aged Brie', 25, 50) }

          it "does not increment quality" do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context "current item sell_in is 0" do
        let(:item) { Item.new('Aged Brie', 0, 20) }

        context "current quality < 49" do
          it "increments quality by 2" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end

        context "current quality is 49" do
          let(:item) { Item.new('Aged Brie', 0, 49) }

          it "increments quality by 1" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end
      end

      context "current item sell_in is < 0" do
        let(:item) { Item.new('Aged Brie', -1, 20) }

        context "current quality is < 49" do
          it "increments quality by 2" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end

        context "current quality is 49" do
          let(:item) { Item.new('Aged Brie', -1, 49) }

          it "increments quality by 1" do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end
      end
    end

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

end
