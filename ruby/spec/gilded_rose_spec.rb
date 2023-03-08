## require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative '../gilded_rose'

RSpec.describe GildedRose do
  describe '#update_quality' do
    let(:items) { [item] }
    let(:gilded_rose) { GildedRose.new(items) }

    describe 'updating sell_in' do
      let(:item) { Item.new('any item', -1, 49) }

      it 'decrements sell_in' do
        expect { gilded_rose.update_quality }
          .to change { item.sell_in }
          .by(-1)
      end
    end

    describe 'standard item' do
      context 'current item sell_in > 1' do
        context 'current item quality > 0' do
          let(:item) { Item.new('Standard item', 25, 30) }

          it 'decrements quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(-1)
          end
        end

        context 'current item quality is 0' do
          let(:item) { Item.new('Standard item', 25, 0) }

          it 'does not change quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context 'current item sell_in is 0' do
        context 'current item quality > 0' do
          let(:item) { Item.new('Standard item', 0, 20) }

          it 'decrements quality by 2' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(-2)
          end
        end

        context 'current item quality is 1' do
          let(:item) { Item.new('Standard item', 0, 1) }

          it 'decrements quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(-1)
          end
        end

        context 'current item quality is 0' do
          let(:item) { Item.new('Standard item', 0, 0) }

          it 'does not decrements quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end
    end

    describe 'sulfuras' do
      let(:item) { Item.new('Sulfuras, Hand of Ragnaros', 25, 80) }

      it 'does not change quality' do
        expect { gilded_rose.update_quality }
          .not_to change { item.quality }
      end

      it 'does not change sell_in' do
        expect { gilded_rose.update_quality }
          .not_to change { item.sell_in }
      end
    end

    describe 'backstage passes' do
      context 'current item sell_<= 0' do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20) }

        it 'initialises quality to 0' do
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

      context 'current item sell_in > 10' do
        context 'current quality is < 50' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 25, 20) }

          it 'increments quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality is 50' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 25, 50) }

          it 'it does not increment quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context 'current item sell_in < 11' do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20) }

        it 'increments quality by 2' do
          expect { gilded_rose.update_quality }
            .to change { item.quality }
            .by(2)
        end

        context 'current quality is 49' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49) }
          it 'increments quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end

          context 'current quality is 50' do
            let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 50) }

            it 'does not increment quality' do
              expect { gilded_rose.update_quality }
                .not_to change { item.quality }
            end
          end
        end
      end

      context 'current item sell_in < 6' do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20) }

        it 'increments quality by 3' do
          expect { gilded_rose.update_quality }
            .to change { item.quality }
            .by(3)
        end

        context 'current quality is 48' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 48) }

          it 'increments quality by 2' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end

        context 'current quality is 49' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49) }

          it 'increments quality by 2' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality is 50' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 50) }

          it 'does not increment quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end
    end

    describe 'aged brie' do
      context 'current item sell_in > 1' do
        context 'current quality is < 50' do
          let(:item) { Item.new('Aged Brie', 25, 20) }

          it 'increments quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality equals 49' do
          let(:item) { Item.new('Aged Brie', 25, 49) }

          it 'does not increment quality' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality equals 50' do
          let(:item) { Item.new('Aged Brie', 25, 50) }

          it 'does not increment quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context 'current item sell_in is 0' do
        context 'current quality < 49' do
          let(:item) { Item.new('Aged Brie', 0, 20) }

          it 'increments quality by 2' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end

        context 'current quality is 49' do
          let(:item) { Item.new('Aged Brie', 0, 49) }

          it 'increments quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality is 50' do
          let(:item) { Item.new('Aged Brie', 0, 50) }

          it 'does not increment quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end

      context 'current item sell_in is < 0' do
        context 'current quality is < 49' do
          let(:item) { Item.new('Aged Brie', -1, 20) }

          it 'increments quality by 2' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(2)
          end
        end

        context 'current quality is 49' do
          let(:item) { Item.new('Aged Brie', -1, 49) }

          it 'increments quality by 1' do
            expect { gilded_rose.update_quality }
              .to change { item.quality }
              .by(1)
          end
        end

        context 'current quality is 50' do
          let(:item) { Item.new('Aged Brie', -1, 50) }

          it 'does not increment quality' do
            expect { gilded_rose.update_quality }
              .not_to change { item.quality }
          end
        end
      end
    end

    describe 'item name' do
      let(:item) { Item.new('foo', 0, 0) }

      it 'does not change the name' do
        expect { gilded_rose.update_quality }
          .not_to change { item.name }
      end
    end
  end
end
