using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace TestDemo.Models.CustomModels
{
    public class EmpModel
    {
        public long EmpId { get; set; }
         
        [Required(ErrorMessage = "Name is Required.")]
        public string EmpName { get; set; }
        public string EmpAddress { get; set; }
        public string EmpGender { get; set; }
        public string EmpHobby { get; set; }

        [Required(ErrorMessage = "Employee Designation is Required.")]
        public Nullable<long> EmpDesignation { get; set; }
        public Nullable<bool> IsDelete { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.DateTime> DeletedDate { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }

        [Required(ErrorMessage = "Email is Requirde")]
        [RegularExpression(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                            @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                            @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$",
                            ErrorMessage = "Email is not valid.")]
        public string EmpEmail { get; set; }

        public string HName { get; set; }

        public string DesName { get; set; }

        public List<EmpModel> empList { get; set; }

        public List<HobbyList> hbList { get; set; }

        public string EmpImage { get; set; }
    }

    public class HobbyList
    {
        public long ID { get; set; }
        public string HName { get; set; }
        public bool selelcted { get; set; }
    }

}