location = Location.create(user: User.first, name: 'Insanity', formatted_address: 'Mittermaierstraße 21 69115 Heidelberg', route: 'Mittermaierstraße', street_number: '21', postal_code: '69115', locality: 'Heidelberg',  lat: '49.4068118', lng: '8.6749252')

open_do = OpeningHour.create(location: location, week_day: 4, start_time: '12:00', end_time: '01:00')
open_fr = OpeningHour.create(location: location, week_day: 5, start_time: '12:00', end_time: '01:00')
open_sa = OpeningHour.create(location: location, week_day: 6, start_time: '12:00', end_time: '01:00')
open_so = OpeningHour.create(location: location, week_day: 0, start_time: '12:00', end_time: '01:00')

event = Event.create(location_id: location.id, name: "Insanity Party Night", category: "MusicEvent",
                     description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", 
                     start_date: eventstart, end_date: eventnd)

ticket1 = Ticket.create(event: event, name: "Ticketkategorie 1", url: "https://www.example.de", status: "https://schema.org/InStock")
ticket2 = Ticket.create(event: event, name: "Ticketkategorie 2", url: "https://www.example.de", status: "https://schema.org/SoldOut")