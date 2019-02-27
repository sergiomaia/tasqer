require 'table_print'

module TASQER
  class Manager
    attr_reader :list

    def initialize
      @list ||= begin
          TASQER::FileManager.read.map do |row|
          TASQER::Task.new(id: row[0].to_i, description: row[1], done: row[2] == 'true')
        end
      end
    end

    def display_list
      if list.any?
        tp list.map(&:details)
      else
        puts 'You have no task added yet.'
      end
    end

    def find_by_id(id)
      list.find { |task| task.id == id }
    end

    def add
      print 'Add new task description: '
      description = gets.chomp

      list << TASQER::Task.new(description: description)
      save

      puts 'Task added successfuly!'
    end

    def toggle
      print 'Enter the task id to be update: '
      id = gets.chomp.to_i

      old_task = find_by_id(id)

      if old_task
        updated_task = old_task.dup
        updated_task.done = !old_task.done
        list[list.index(old_task)] = updated_task
        save

        puts 'Task status changed successfully!'
      else
        puts 'Task id not found. '
      end
    end

    def remove
      print 'Enter the task id to be remove: '
      id = gets.chomp.to_i
      task = find_by_id(id)

      if task
        list.delete(task)
        save

        puts 'Task removed successfully!'
      else
        puts 'Task not found'
      end
    end

    def save
      TASQER::FileManager.persist(list.map(&:to_s).join("\n"))
    end
  end
end
