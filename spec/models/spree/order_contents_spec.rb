require 'spec_helper'

describe Spree::OrderContents do
    before :each do
        @order = Spree::Order.create
        @product = FactoryGirl.create(:product)
        @product.master.stock_items.first.update_attribute(:count_on_hand, 10)
        @contact_lens = FactoryGirl.create(:contact_lens)
        category = @contact_lens.contact_lens_category
        item = FactoryGirl.create(:contact_lens_item, contact_lens_category: category)
        @value_1 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)
        @value_2 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)
    end

    context "add" do
        context "variant doesn't belong to a ContactLens" do
            it "keeps normal behaviour" do
                @order.contents.add(@product.master, 1)
                line_item = @order.contents.add(@product.master, 1)

                expect(line_item.quantity).to eq 2
                expect(@order.line_items.size).to eq 1
            end
        end

        context "variant belongs to a ContactLens" do
            before :each do
                @options = {eye: 'left', values: [@value_1.id]}
            end

            it "keeps normal behaviour if already exists a line item with same :eye and same :options" do
                @order.contents.add(@contact_lens.master, 1, nil, nil, @options)
                line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options)

                expect(line_item.reload.quantity).to eq 2
                expect(@order.line_items.size).to eq 1
            end

            it "adds a line item when doesn't exist a line item with same :eye and same :options" do
                line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options)

                expect(line_item.quantity).to eq 1
                expect(@order.line_items.size).to eq 1
            end

            context "doesn't exist a line item with same :eye and same :options" do
                it "adds a second line item if :eye is diferent" do
                    line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options)
                    second_line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options.merge({eye: 'right'}))

                    expect(line_item.quantity).to eq 1
                    expect(second_line_item.quantity).to eq 1
                    expect(@order.line_items.size).to eq 2
                end

                it "adds a second line item if :options is diferent" do
                    line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options)
                    second_line_item = @order.contents.add(@contact_lens.master, 1, nil, nil, @options.merge({values: [@value_2.id]}))

                    expect(line_item.quantity).to eq 1
                    expect(second_line_item.quantity).to eq 1
                    expect(@order.line_items.size).to eq 2
                end
            end
        end
    end

    context "remove" do
        context "variant doesn't belong to a ContactLens" do
            it "keeps normal behaviour" do
                @order.contents.add(@product.master, 1)
                @order.contents.remove(@product.master, 1)

                @order.reload

                expect(@order.find_line_item_by_variant(@product.master)).to be_nil
                expect(@order.line_items.size).to eq 0
            end
        end

        context "variant belongs to a ContactLens" do
            before :each do
                @options = {eye: 'left', values: [@value_1.id]}
            end

            it "keeps normal behaviour if exists only one line item" do
                @order.contents.add(@contact_lens.master, 1, nil, nil, @options)
                @order.contents.remove(@contact_lens.master, 1, nil, @options)

                @order.reload

                expect(@order.find_line_item_by_variant(@product.master)).to be_nil
                expect(@order.line_items.size).to eq 0
            end

            context "raises an exception" do
                it "when :eye doesn't match" do
                    @order.contents.add(@contact_lens.master, 1, nil, nil, @options)

                    expect {
                        @order.contents.remove(@contact_lens.master, 1, nil, @options.merge({eye: 'right'}))
                    }.to raise_error(ActiveRecord::RecordNotFound)
                end

                it "when :options doesn't match" do
                    @order.contents.add(@contact_lens.master, 1, nil, nil, @options)

                    expect {
                        @order.contents.remove(@contact_lens.master, 1, nil, @options.merge({values: [@value_2.id]}))
                    }.to raise_error(ActiveRecord::RecordNotFound)
                end
            end

            it "removes only the line item with matched :eye and :options" do
                @order.contents.add(@contact_lens.master, 1, nil, nil, @options)
                @order.contents.add(@contact_lens.master, 1, nil, nil, @options.merge({eye: 'right'}))

                @order.contents.remove(@contact_lens.master, 1, nil, @options.merge({eye: 'right'}))

                @order.reload

                expect(@order.find_line_item_by_variant(@contact_lens.master)).to be_valid
                expect(@order.find_line_item_by_variant(@contact_lens.master).eye).to eq 'left'
                expect(@order.line_items.size).to eq 1
            end
        end
    end
end
