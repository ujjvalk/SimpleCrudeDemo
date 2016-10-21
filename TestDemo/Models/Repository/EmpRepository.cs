using System;
using System.Collections.Generic;
using System.Linq;
using TestDemo.Models.CustomModels;

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
            string ret = string.Empty;

            using (var db = new TestDemoEntities())
            {
                if (id != null)
                {
                    string[] hobbyId = id.Split(',');
                    foreach (var item in hobbyId)
                    {
                        long hid = Convert.ToInt64(item);
                        var data = db.tblHobbies.Where(e => e.HobbyId == hid).Select(x => x.HName).First();
                        if (string.IsNullOrEmpty(ret))
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
                                               EmpImage = e.EmpImage,
                                               Birthdate = e.Birthdate
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
                                               EmpEmail = x.EmpEmail,
                                               EmpImage = x.EmpImage,
                                               Birthdate = x.Birthdate
                                           }).ToList();
                }
                return pageDetails;
            }
            catch (Exception)
            {
                return new EmpModel();
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
                details.EmpImage = data.EmpImage;
                details.Birthdate = data.Birthdate;
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
                        pageData.EmpImage = model.EmpImage;
                        pageData.Birthdate = model.Birthdate;
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
                        data.EmpImage = emp.EmpImage;
                        data.Birthdate = emp.Birthdate;
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
                        return true;
                    }
                }
                return false;
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
            if (!this._disposed)
            {
                if (disposing)
                {
                    using (var db = new TestDemoEntities())
                    {
                        db.Dispose();
                    }
                }
            }
            this._disposed = true;
        }

        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }


        #endregion
    }
}