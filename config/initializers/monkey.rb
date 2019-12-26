module ActiveRecord
  module ConnectionAdapters
    class TableDefinition
      def timestamps(**options)
        options[:null] = false if options[:null].nil?

        column(:created_at, :datetime, options)
        column(:updated_at, :datetime, options)
        deleted_at_column(options)
      end

      def deleted_at_column(options)
        options[:null] = true
        column(:deleted_at, :datetime, options)
      end
    end
  end
end
