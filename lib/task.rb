module TASQER
  class Task
    attr_reader :id, :description
    attr_accessor :done

    def initialize(id: nil, description:, done: false)
      @id = id || next_id
      @description = description
      @done = done
    end

    def to_s
      [id, description, done].join(',')
    end

    def details
      {id: id, todo: description, done?: done ? '✓' : '■' }
    end

    private

    def next_id
      TASQER::Manager.new.list.map(&:id).max.to_i + 1
    end
  end
end
