module TASQER
  class FileManager
    PERSISTER = 'persister.csv'
    class << self
      def read
        File.readlines(PERSISTER).map { |row| row.chomp.split(',') }
      end

      def persist(content)
        unless content.nil?
          File.open(PERSISTER, 'w') { |file| file.write(content) }
        end
      end
    end
  end
end
