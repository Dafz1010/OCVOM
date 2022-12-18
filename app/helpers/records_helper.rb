module RecordsHelper
    def fakename
        Faker::Name.last_name
    end
    def fakedogname
        Faker::Creature::Dog.name
    end
end
