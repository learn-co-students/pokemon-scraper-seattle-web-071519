# require 'pry'

class Pokemon
    attr_accessor :id, :name, :type, :db, :hp

    def initialize(id:, name:, type:, hp: nil, db:)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = 60
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        # @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id_num, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL
        new_poke_row = db.execute(sql, id_num).flatten
        Pokemon.new(id: new_poke_row[0], name: new_poke_row[1], type: new_poke_row[2], hp: new_poke_row[3], db: db)
    end

    def alter_hp(new_hp, db)
        # sql2 = <<-SQL
        #     UPDATE pokemon SET hp = ? WHERE id = ?
        # SQL
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
    end
end
