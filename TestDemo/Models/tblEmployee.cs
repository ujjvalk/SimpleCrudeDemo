//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestDemo.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblEmployee
    {
        public long EmpId { get; set; }
        public string EmpName { get; set; }
        public string EmpAddress { get; set; }
        public string EmpGender { get; set; }
        public string EmpHobby { get; set; }
        public Nullable<long> EmpDesignation { get; set; }
        public Nullable<bool> IsDelete { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.DateTime> DeletedDate { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string EmpEmail { get; set; }
        public string EmpImage { get; set; }
    }
}
