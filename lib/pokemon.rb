class Pokemon
    attr_accessor :name, :type, :id, :db, :hp
    def initialize(hash)
        self.name = hash[:name]
        self.type = hash[:type]
        self.db = hash[:db]
        if hash.length > 3
            self.hp = hash[:hp]
        else
            self.hp = -1
        end
        self.id = hash[:id]
    end

    def alter_hp(new_value,db)
        @hp = new_value
        save_with_hp(db)
    end

    def save_with_hp(db)
        sql = <<-MIS 
            Insert INTO pokemon(name,type,@) VALUES (?,?) 
        MIS
        db.execute(sql,@name,@type,@hp)
    end
    def Pokemon.save(name,type,db)
        poke = Pokemon.new(id:nil, name: name, type: type, db: db)
        @db = db
        sql = <<-MIS 
            Insert INTO pokemon(name,type) VALUES (?,?) 
        MIS
        @db.execute(sql,name,type)
    end

    def Pokemon.find(id,db)

        sql = <<-MIS 
            SELECT * FROM pokemon WHERE id = ?
        MIS
        result = db.execute(sql,id)
        poke = instantaite_from_db(result)
        poke
    end

    def self.instantaite_from_db(row)
        if row.length < 3
            row[3] = -1
        end
        row= row.flatten
        Pokemon.new(id: row[0], name: row[1], type: row[2], hp: row[3])
    end
end
