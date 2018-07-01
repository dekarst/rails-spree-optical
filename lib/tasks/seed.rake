namespace :seed do
    desc "Distribute the Lenses"
    task distribute_lenses: :environment do
        lens_ids = Lens.all.map(&:id)
        lens_ids_size = lens_ids.size

        FrameLensAssociation.destroy_all

        if lens_ids_size > 0
            Frame.all.each_with_index do |frame, i|
                lens_ids[0, (i % lens_ids_size)+1].each do |lens_id|
                    FrameLensAssociation.create!(frame: frame, lens_id: lens_id)
                end
            end
        end
    end

    desc "Set colors"
    task set_colors: :environment do
        sample_colors = {
            blue: ['#4863A0', '#2B547E', '#15317E', '#157DEC', '#0041C2', '#56A5EC'],
            green: ['#56A5EC', '#617C58', '#347235', '#4E9258', '#5EFB6E'],
            yellow: ['#FFF380', '#FFA62F'],
            red: ['#F62217', '#C11B17', '#E42217'],
            pink: ['#E4287C', '#B93B8F'],
            black: ['#2C3539', '#3B3131', '#0C090A', '#463E3F', '#625D5D', '#3D3C3A'],
        }

        Frame.all.each do |frame|
            frame.colors.each do |color|
                sample_colors.each do |sample_color, codes|
                    if color.name.downcase.include?(sample_color.to_s)
                        color.update_attribute(:color_code, codes.sample)
                        break
                    end
                end
            end
        end
    end

    desc "Set Taxons"
    task set_taxons: :environment do
        Frame.all.each do |frame|
            sample_brands = ['Ray-Ban', 'Persol', 'Costa', 'Dolce Gabbana', 'Gucci', 'Oakley', 'Prada', 'Tom Ford', 'Revo']
            sample_categories = ['Sunglasses', 'Eyeglasses']

            sample_brands.each do |sample_brand|
                if frame.name.downcase.include?(sample_brand.downcase.parameterize)
                    begin
                        Spree::Taxon.find_or_create_by(name: sample_brand, taxonomy_id: 2).products << frame
                    rescue ActiveRecord::RecordInvalid
                    end
                    break
                end
            end

            sample_categories.each do |sample_category|
                if frame.name.downcase.include?(sample_category.downcase)
                    begin
                        Spree::Taxon.find_or_create_by(name: sample_category, taxonomy_id: 1).products << frame
                    rescue ActiveRecord::RecordInvalid
                    end
                    break
                end
            end
        end
    end

    desc "Fix Taxons"
    task fix_taxons: :environment do
        ['Ray-Ban', 'Persol', 'Costa', 'Dolce Gabbana', 'Gucci', 'Oakley', 'Prada', 'Tom Ford', 'Revo'].each do |brand|
            Spree::Taxon.where(name: brand, parent_id: nil).destroy_all
        end
    end
end
