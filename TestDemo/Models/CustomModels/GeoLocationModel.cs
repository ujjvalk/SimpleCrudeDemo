using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestDemo.Models.CustomModels
{
    public class GeoLocationModel
    {
        public long Id { get; set; }
        public string GeoLocationAddress { get; set; }
        public string Latitude { get; set; }
        public string Longiude { get; set; }

        public List<GeoLocationModel> geoList { get; set; }
    }
}