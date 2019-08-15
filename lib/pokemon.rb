class Pokemon

    attr_accessor :name, :type, :id, :db, :hp

    def initialize(input)
        @name = input[:name]
        @type = input[:type]
        @id = input[:id]
        @db = input[:db]
        @hp = input[:hp]
    end

    #saves an instance of a pokemon with the correct id
    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end
    
    #finds a pokemon from the database 
    #by their id number and returns a new Pokemon object
    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id).flatten
        # binding.pry
        Pokemon.new(id: result[0], name: result[1], type: result[2], hp: result[3])
    end

    def alter_hp(hp, db)
        sql = "UPDATE pokemon SET hp = ? WHERE id = ?"
        db.execute(sql, hp, self.id)
        # binding.pry
    end
end

