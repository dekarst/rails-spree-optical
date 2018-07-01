class CreateLensesPrescriptionLensRulesJoinTable < ActiveRecord::Migration
    def change
        create_join_table :lenses, :prescription_lens_rules do |t|
            t.integer :lens_id
            t.integer :prescription_lens_rule_id

            t.index [:lens_id, :prescription_lens_rule_id], name: 'lenses_prescription_lens_rules_on_lid_and_plrid'
            t.index [:prescription_lens_rule_id, :lens_id], name: 'lenses_prescription_lens_rules_on_plrid_and_lid'
        end
    end
end
