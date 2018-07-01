class CreateFaceShapesSpreeProductsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :face_shapes, :spree_products do |t|
      t.index [:face_shape_id, :spree_product_id], name: 'idx_face_shapes_sp_products_face_shape_id_and_sp_product_id'
      t.index [:spree_product_id, :face_shape_id], name: 'idx_face_shapes_sp_products_sp_product_id_and_face_shape_id'
    end
  end
end
