module TASQER
  class Interface

    OPTIONS = {
      a: "Add new task(+)",
      d: "Change task status",
      r: "Remove task(-)",
      q: "Quit!"
    }

    class << self
      def clear
        system(Gem.win_platform? ? 'cls' : 'clear')
      end

      def start(name_version)
        return unless name_version
        puts "-----#{name_version}-----\n\n"
      end

      def display_options
        OPTIONS.each do |key, description|
          puts "#{key} - #{description}"
        end

        puts
      end
    end
  end
end
