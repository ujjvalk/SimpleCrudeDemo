using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TestDemo.Models.CustomModels;
using TestDemo.Models;

namespace TestDemo.Models.Repository
{
    public class EmpRepository : IDisposable
    {
        #region GetDesignation

        public List<tblDesignation> degList()
        {
            using (var db = new TestDemoEntities())
            {
                return db.tblDesignations.ToList();
            }
        }

        #endregion

        #region GetHobby

        public List<HobbyList> hbList(string[] id = null)
        {
            var list = new List<HobbyList>();
            using (var db = new TestDemoEntities())
            {
                var data = db.tblHobbies.ToList();
                foreach (var item in data)
                {
                    HobbyList obj = new HobbyList();
                    obj.ID = item.HobbyId;
                    obj.HName = item.HName;
                    if (id != null && id.Contains(obj.ID.ToString()))
                    {
                        obj.selelcted = true;
                    }
                    else
                    {
                        obj.selelcted = false;
                    }
                    list.Add(obj);
                }
            }
            return list;
        }

        #endregion

        #region GetHobbyString

        public static string GetHobbyString(string id)
        {
            string ret = "";

            using (var db = new TestDemoEntities())
            {
                if (id != null)
                {
                    string[] hobbyId = id.Split(',');
                    foreach (var item in hobbyId)
                    {
                        long hid = Convert.ToInt64(item);
                        var data = db.tblHobbies.Where(e => e.HobbyId == hid).Select(x => x.HName).First();
                        if (ret == "")
                        {
                            ret = data;
                        }
                        else
                        {
                            ret = ret + "," + data;
                        }

                    }

                }
            }
            return ret;
        }

        #endregion

        #region GetList
        public EmpModel GetList()
        {
            try
            {
                EmpModel pageDetails = new EmpModel();
                using (var db = new TestDemoEntities())
                {
                    pageDetails.empList = (from e in db.tblEmployees
                                           join d in db.tblDesignations on e.EmpDesignation equals d.DesignationId into ems
                                           from j in ems.DefaultIfEmpty()
                                           where e.IsDelete == false
                                           select new EmpModel()
                                           {
                                               EmpId = e.EmpId,
                                               EmpAddress = e.EmpAddress,
                                               EmpName = e.EmpName,
                                               EmpGender = e.EmpGender,
                                               DesName = j.DesName,
                                               EmpHobby = e.EmpHobby,
                                               EmpEmail = e.EmpEmail,
                                               
                                           })
                                           .AsEnumerable()
                                           .Select(x => new EmpModel
                                           {
                                               EmpId = x.EmpId,
                                               EmpAddress = x.EmpAddress,
                                               EmpName = x.EmpName,
                                               EmpGender = x.EmpGender,
                                               DesName = x.DesName,
                                               HName = GetHobbyString(x.EmpHobby),
                                               EmpEmail = x.EmpEmail
                                           }).ToList();
                }
                return pageDetails;
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region GetById
        public EmpModel GetById(long id)
        {
            using (var db = new TestDemoEntities())
            {
                EmpModel details = new EmpModel();
                var data = db.tblEmployees.Where(m => m.EmpId == id).FirstOrDefault();
                details.EmpId = data.EmpId;
                details.EmpName = data.EmpName;
                details.EmpEmail = data.EmpEmail;
                details.IsActive = Convert.ToBoolean(data.IsActive);
                details.EmpAddress = data.EmpAddress;
                details.EmpDesignation = data.EmpDesignation;
                details.EmpGender = data.EmpGender;
                details.EmpHobby = data.EmpHobby;
                return details;
            }
        }

        #endregion

        #region Add Data
        public bool AddData(EmpModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var pageData = new tblEmployee();
                    {
                        pageData.EmpName = model.EmpName;
                        pageData.EmpEmail = model.EmpEmail;
                        pageData.EmpAddress = model.EmpAddress;
                        pageData.CreatedDate = DateTime.Now;
                        pageData.ModifiedDate = DateTime.Now;
                        pageData.IsActive = true;
                        pageData.IsDelete = false;
                        pageData.EmpDesignation = model.EmpDesignation;
                        pageData.EmpHobby = model.EmpHobby;
                        pageData.EmpGender = model.EmpGender;
                        db.tblEmployees.Add(pageData);
                        db.SaveChanges();
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Edit Data
        public bool EditData(EmpModel emp)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = (from sm in db.tblEmployees
                                where sm.EmpId == emp.EmpId
                                select sm).FirstOrDefault();
                    if (data != null)
                    {
                        data.EmpName = emp.EmpName;
                        data.EmpEmail = emp.EmpEmail;
                        data.EmpGender = emp.EmpGender;
                        data.EmpHobby = emp.EmpHobby;
                        data.EmpDesignation = emp.EmpDesignation;
                        data.EmpAddress = emp.EmpAddress;
                        data.IsActive = emp.IsActive;
                        db.SaveChanges();
                        return true;
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Delete Record
        public bool DeleteRecord(long Id)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = db.tblEmployees.Find(Id);
                    if (data != null)
                    {
                        data.IsDelete = true;
                        data.DeletedDate = DateTime.Now;
                        db.Entry(data).CurrentValues.SetValues(data);
                        db.SaveChanges();
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Disposible

        private bool _disposed = false;

        private void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    using (var db = new TestDemoEntities())
                    {
                        db.Dispose();
                    }
                }
            }
            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }


        #endregion
    }
}