# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Role.create!({name: "admin"})
Role.create!({name: "Doctor"})
Role.create!({name: "Frontliner"})
Role.create!({name: "Encoder"})     

User.create!([{name: "Administrator", username: "admin", password: "admin123", password_confirmation: "admin123", role_id: 1, approved_at: Time.now}])

Condition.create!(name: "Healthy")
Condition.create!(name: "Adopted")
Condition.create!(name: "Unhealthy or Injured")
Condition.create!(name: "Recovery")
Condition.create!(name: "Disposed")
Condition.create!(name: "Lost")

[
    "0 to 2 months",
    "3 to 4 months",
    "5 to 6 months",
    "7 to 8 months",
    "9 to 10 months",
    "11 to 12 months"
].each do |age|
    AgeList.create!(name: age, group: "Young")
end
[
    "1 to 3 years",
    "4 to 6 years",
    "7 to 10 years",
    "11 to 15 years",
    "16 to 20 years",
    "20 years and above"
].each do |age|
    AgeList.create!(name: age, group: "Adult")
end

Breed.create!(name: "Beagle")
Breed.create!(name: "Aspin")
Breed.create!(name: "Chihuahua")
Breed.create!(name: "Pomeranian")
Breed.create!(name: "Shih Tzu")
Breed.create!(name: "Labrador")
Breed.create!(name: "Golden Retriever")
Breed.create!(name: "German Shepherd")
Breed.create!(name: "Belgian Mallanois")
Breed.create!(name: "Siberian Husky")
Breed.create!(name: "Alaskan Malamute")
Breed.create!(name: "American Bulldog")
Breed.create!(name: "French Bulldog")
Breed.create!(name: "English Bulldog")
Breed.create!(name: "Pug")
Breed.create!(name: "Rottweiler")
Breed.create!(name: "St. Bernard")
Breed.create!(name: "Corgi")
Breed.create!(name: "Border Collie")
Breed.create!(name: "Youkshire Terrier")
Breed.create!(name: "Bichon Frise")
Breed.create!(name: "Poddle")
Breed.create!(name: "Duchshund")
Breed.create!(name: "Bull Mastiff")
Breed.create!(name: "Jack Russel Terrier")
Breed.create!(name: "Schnauzer")
Breed.create!(name: "Greatdane")
Breed.create!(name: "Dalmatian")
Breed.create!(name: "Japanese Spitz")
Breed.create!(name: "Boston Terrier")
Breed.create!(name: "Dobermann")
Breed.create!(name: "Cocker Spaniel")
Breed.create!(name: "Mini Pincher")
Breed.create!(name: "Lhasa Apso")
Breed.create!(name: "Pekingese")
Breed.create!(name: "Scottish Terrier")

Place.create!(name: "Airport")
Place.create!(name: "Alegria")
Place.create!(name: "Alta Vista")
Place.create!(name: "Bagong")
Place.create!(name: "Bagong Buhay")
Place.create!(name: "Bantigue")
Place.create!(name: "District 1 (Brgy. South)")
Place.create!(name: "District 10 (Brgy. East)")
Place.create!(name: "District 11 (Brgy. East)")
Place.create!(name: "District 12 (Brgy. South)")
Place.create!(name: "District 13 (Brgy. South)")
Place.create!(name: "District 14 (Brgy. West)")
Place.create!(name: "District 15 (Brgy. South)")
Place.create!(name: "District 16 (Brgy. East)")
Place.create!(name: "District 17 (Brgy. South)")
Place.create!(name: "District 18 (Brgy. East)")
Place.create!(name: "District 19 (Brgy. West)")
Place.create!(name: "District 2 (Brgy. South)")
Place.create!(name: "District 20 (Brgy. West)")
Place.create!(name: "District 21 (Brgy. West)")
Place.create!(name: "District 22 (Brgy. West)")
Place.create!(name: "District 23 (Brgy. South)")
Place.create!(name: "District 24 (Brgy. South)")
Place.create!(name: "District 25 (Brgy. East)")
Place.create!(name: "District 26 (Brgy. West)")
Place.create!(name: "District 27 (Brgy. East)")
Place.create!(name: "District 28 (Brgy. East)")
Place.create!(name: "District 29 (Brgy. North)")
Place.create!(name: "District 3 (Brgy. South)")
Place.create!(name: "District 4 (Brgy. South)")
Place.create!(name: "District 5 (Brgy. South)")
Place.create!(name: "District 6 (Brgy. South)")
Place.create!(name: "District 7 (Brgy. South)")
Place.create!(name: "District 8 (Brgy. South)")
Place.create!(name: "District 9 (Brgy. East)")
Place.create!(name: "Batuan")
Place.create!(name: "Bayog")
Place.create!(name: "Biliboy")
Place.create!(name: "Borok")
Place.create!(name: "Cabaon-an")
Place.create!(name: "Cabintan")
Place.create!(name: "Cabulihan")
Place.create!(name: "Cagbuhangin")
Place.create!(name: "Camp Downes")
Place.create!(name: "Can-adieng")
Place.create!(name: "Can-untog")
Place.create!(name: "Catmon")
Place.create!(name: "Cogon Combado")
Place.create!(name: "Concepcion")
Place.create!(name: "Curva")
Place.create!(name: "Danao")
Place.create!(name: "Danhug")
Place.create!(name: "Dayhagan")
Place.create!(name: "Dolores")
Place.create!(name: "Domonar")
Place.create!(name: "Don Felipe Larrazabal")
Place.create!(name: "Don Potenciano Larrazabal")
Place.create!(name: "Doña Feliza Z. Mejia")
Place.create!(name: "Donghol")
Place.create!(name: "Esperanza")
Place.create!(name: "Gaas")
Place.create!(name: "Green Valley")
Place.create!(name: "Guintigui-an")
Place.create!(name: "Hibunawon")
Place.create!(name: "Hugpa")
Place.create!(name: "Ipil")
Place.create!(name: "Juaton")
Place.create!(name: "Kadaohan")
Place.create!(name: "Labrador")
Place.create!(name: "Lao")
Place.create!(name: "Leondon")
Place.create!(name: "Libertad")
Place.create!(name: "Liberty")
Place.create!(name: "Licuma")
Place.create!(name: "Liloan")
Place.create!(name: "Linao")
Place.create!(name: "Luna")
Place.create!(name: "Mabato")
Place.create!(name: "Mabin")
Place.create!(name: "Macabug")
Place.create!(name: "Magaswi")
Place.create!(name: "Mahayag")
Place.create!(name: "Mahayahay")
Place.create!(name: "Manlilinao")
Place.create!(name: "Margen")
Place.create!(name: "Mas-in")
Place.create!(name: "Matica-a")
Place.create!(name: "Milagro")
Place.create!(name: "Monterico")
Place.create!(name: "Nasunogan")
Place.create!(name: "Naungan")
Place.create!(name: "Nueva Sociedad")
Place.create!(name: "Nueva Vista")
Place.create!(name: "Patag")
Place.create!(name: "Punta")
Place.create!(name: "Quezon, Jr.")
Place.create!(name: "Rufina M. Tan")
Place.create!(name: "Sabang Bao")
Place.create!(name: "Salvacion")
Place.create!(name: "San Antonio")
Place.create!(name: "San Isidro")
Place.create!(name: "San Jose")
Place.create!(name: "San Juan")
Place.create!(name: "San Pablo")
Place.create!(name: "San Vicente")
Place.create!(name: "Santo Niño")
Place.create!(name: "Sumangga")
Place.create!(name: "Tambulilid")
Place.create!(name: "Tongonan")
Place.create!(name: "Valencia")

DogState.create!(name: "Open for Adoption")
DogState.create!(name: "Lost Dog")
DogState.create!(name: "In hold")
DogState.create!(name: "Operation")

Vaccine.create!(name: "Anti Rabies")
Vaccine.create!(name: "Deworm")
Vaccine.create!(name: "Parvo shots")