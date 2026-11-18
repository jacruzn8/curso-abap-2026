@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Using Associations and path Expressions'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_I_Connection_C as select from /DMO/I_Connection_R
//{
//    key AirlineID,
//    key ConnectionID,
//    
//    
//    DepartureAirport,
//    DestinationAirport,
//    DepartureTime,
//    ArrivalTime,
//    Distance,
//    DistanceUnit,
//    /* Associations */
//    _Airline,
//    _Flight
//}

//{
//key AirlineID,
//key ConnectionID,
//
//// _Airline.CurrencyCode,
//// _Flight.PlaneType,
//
//DepartureAirport,
//DestinationAirport
//
//}
//where
//AirlineID = 'LH'          // Only one connection
//
//// and ConnectionID = '0400' // fulfills this filter
//
//
//// and _Airline.CurrencyCode = 'EUR'
//// and _Flight.PlaneType = '747-400'


//{
//    key AirlineID,
//    key ConnectionID,
//
//        _Flight.OccupiedSeats
//        //        sum(_Flight.OccupiedSeats) as TotalOccupiedSeats
//
//  }
//where
//      AirlineID    = 'LH'   // Only one connection
//  and ConnectionID = '0400' // fulfills this condition
//
//  group by
//    AirlineID,
//    ConnectionID,
//    _Flight.OccupiedSeats

// Try Out: Filtered Associations
 
{
    key AirlineID,
    key ConnectionID,

 //       _Airline._Currency._Text.CurrencyName

//        _Airline._Currency._Text[ Language = 'E' ].CurrencyName

        _Airline._Currency._Text[ 1: Language = 'E' ].CurrencyName
  }
where
      AirlineID    = 'AA'
  and ConnectionID = '0017'
 
