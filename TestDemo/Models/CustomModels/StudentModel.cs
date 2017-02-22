using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestDemo.Models.CustomModels
{
    public class StudentModel
    {
        public int StudentId { get; set; }
        public string StudentName { get; set; }
        public int? StudentAge { get; set; }
        public string StudentAddress { get; set; }
        public DateTime? BirthDate { get; set; }
        public int? ClassId { get; set; }
        public int? Standard { get; set; }
        public string Photo { get; set; }
        public string Hobby { get; set; }

        public string Class { get; set; }

        public List<StudentModel> StudentList { get; set; }
    }
}