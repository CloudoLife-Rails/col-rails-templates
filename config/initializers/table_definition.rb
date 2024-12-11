
# config/initializers/custom_migration_methods.rb
module ActiveRecord
  module ConnectionAdapters
    class TableDefinition
      #
      # Adds standard trailable columns to a table.
      #
      # @param options [Hash] Options for customizing the columns.
      # @option options [Symbol] :type (:integer) The type to use for ID columns (creator_id, updater_id, deleter_id).
      # @option options [Boolean] :indexable (true) Whether to add indexes to the columns.
      #
      # The following columns are added:
      # - created_at (with index if indexable)
      # - created_by (string, with index if indexable)
      # - creator_id (with specified type, with index if indexable)
      # - updated_at (with index if indexable)
      # - updated_by (string, with index if indexable)
      # - updater_id (with specified type, with index if indexable)
      # - deleted_at (datetime, with index if indexable)
      # - deleted_by (string, with index if indexable)
      # - deleter_id (with specified type, with index if indexable)
      # - lock_version (integer, default: 0)
      def trailable_columns(options = {})
        id_type = options[:type] || :integer
        indexable = options[:indexable] || true

        # created
        index :created_at if indexable

        column :created_by, :string
        index :created_by if indexable

        column :creator_id, id_type
        index :creator_id if indexable

        # updated
        index :updated_at if indexable

        column :updated_by, :string
        index :updated_by if indexable

        column :updater_id, id_type
        index :updater_id if indexable

        # deleted
        column :deleted_at, :datetime
        index :deleted_at if indexable

        column :deleted_by, :string
        index :deleted_by if indexable

        column :deleter_id, id_type
        index :deleter_id if indexable

        # lock
        column :lock_version, :integer, default: 0
      end
    end
  end
end
