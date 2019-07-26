class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(id: nil, name:, type:, hp: nil, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
        SQL
        rows = db.execute(sql)
        mon = rows.find do |row|
            row[0] == id           
        end
        mon_object = Pokemon.new(id: mon[0], name: mon[1], type: mon[2], hp: 60, db: db)
        mon_object
    end

    def alter_hp
        
    end

end
