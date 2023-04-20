module RecordsHelper
    def fakename
        Faker::Name.last_name
    end

    def fakedogname
        Faker::Creature::Dog.name
    end

    def archivable?(record)
        current_user.admin? || current_user?(record.user) || current_user.doctor?
    end
end
