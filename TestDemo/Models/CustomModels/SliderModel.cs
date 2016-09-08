using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestDemo.Models.CustomModels
{
    public class SliderModel
    {
        public int SliderId { get; set; }
        public string SImage { get; set; }
        public bool? IsActive { get; set; }
        public bool? IsDelete { get; set; }

        public List<SliderModel> sliderList { get; set; }

        public IEnumerable<HttpPostedFileBase> ImageS { get; set; }
    }
}