using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;

namespace TestDemo.Models.Repository
{
    public class StudentRepository : IDisposable
    {

        #region Get StudentClasses
        public SelectList ClassList(int classId)
        {
            //List<SelectListItem> items = new List<SelectListItem>
            //{
            //    new SelectListItem {Text = "A",Value = "A"},
            //     new SelectListItem {Text = "B",Value = "B"},
            //      new SelectListItem {Text = "C",Value = "C"},
            //       new SelectListItem {Text = "D",Value = "D"}

            //    //new SelectListItem {Text = Enum.BannerType.HeaderBanner.ToString(),Value = Enum.BannerType.HeaderBanner.ToString()},
            //    //new SelectListItem {Text = Enum.BannerType.SideBanner.ToString(), Value = Enum.BannerType.SideBanner.ToString()},

            //};
            //return new SelectList(items, "Value", "Text", id);
            using (var db = new TestDemoEntities())
            {
                var classsList = (from rm in db.StudentClasses
                                  select new { Value = rm.ClassId, Text = rm.Class }).ToList();
                return new SelectList(classsList, "Value", "Text", classId);
            }
        }
        #endregion

        #region Get StudentCourse
        public List<StudentCourse> CourseList()
        {
            using (var db = new TestDemoEntities())
            {
                var data = db.StudentCourses.ToList();
                return data;
            }
        }
        #endregion

        #region Get StudentCourseSelected
        public List<StudentCourse> SelectedCourseList(int studentId)
        {
            using (var db = new TestDemoEntities())
            {
                var selectedValue = (from c in db.StudentCourses
                                     join m in db.StudentCourseMappings on c.CourseId equals m.courseId
                                     where m.studentId == studentId
                                     select new
                                     {
                                         CourseId = m.courseId,
                                         CourseName = c.CourseName
                                     }).AsEnumerable()
                                                   .Select(x => new StudentCourse
                                                   {
                                                       CourseId = x.CourseId,
                                                       CourseName = x.CourseName
                                                   }).ToList();
                return selectedValue;
            }
        }
        #endregion

        #region GetList
        public StudentModel GetList()
        {
            try
            {
                StudentModel pageDetails = new StudentModel();
                using (var db = new TestDemoEntities())
                {
                    pageDetails.StudentList = (from s in db.Students
                                               join c in db.StudentClasses on s.ClassId equals c.ClassId into cms
                                               from c in cms.DefaultIfEmpty()
                                               select new StudentModel
                                               {
                                                   BirthDate = s.BirthDate,
                                                   Class = c.Class,
                                                   ClassId = s.ClassId,
                                                   Photo = s.Photo,
                                                   Standard = s.Standard,
                                                   StudentAddress = s.studentAddress,
                                                   StudentAge = s.studentAge,
                                                   StudentId = s.studentId,
                                                   StudentName = s.studentName,
                                                   Hobby = s.hobby
                                               }).AsEnumerable()
                                           .Select(x => new StudentModel
                                           {
                                               BirthDate = x.BirthDate,
                                               Class = x.Class,
                                               ClassId = x.ClassId,
                                               Photo = x.Photo,
                                               Standard = x.Standard,
                                               StudentAddress = x.StudentAddress,
                                               StudentAge = x.StudentAge,
                                               StudentId = x.StudentId,
                                               StudentName = x.StudentName,
                                               Hobby = x.Hobby
                                           }).ToList();
                }
                return pageDetails;
            }
            catch (Exception)
            {
                return new StudentModel();
            }
        }
        #endregion

        #region GetById
        public StudentModel GetById(int id)
        {
            using (var db = new TestDemoEntities())
            {
                StudentModel details = new StudentModel();
                var data = (from s in db.Students
                            join c in db.StudentClasses on s.ClassId equals c.ClassId into cms
                            from c in cms.DefaultIfEmpty()
                            where s.studentId == id
                            select new
                            {
                                s.studentId,
                                s.Photo,
                                s.BirthDate,
                                s.Standard,
                                s.StudentClass,
                                s.studentAddress,
                                s.studentAge,
                                s.studentName,
                                s.ClassId,
                                c.Class,
                                s.hobby
                            }).FirstOrDefault();
                if (data != null)
                {
                    details.BirthDate = data.BirthDate;
                    details.Class = data.Class;
                    details.ClassId = data.ClassId;
                    details.Photo = data.Photo;
                    details.Standard = data.Standard;
                    details.StudentAddress = data.studentAddress;
                    details.StudentAge = data.studentAge;
                    details.StudentName = data.studentName;
                    details.StudentId = data.studentId;
                    details.Hobby = data.hobby;
                }
                return details;
            }
        }

        #endregion

        #region Add Data
        public bool AddData(StudentModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var pageData = new Student();
                    {
                        pageData.BirthDate = model.BirthDate;
                        pageData.ClassId = model.ClassId;
                        pageData.Photo = model.Photo;
                        pageData.Standard = model.Standard;
                        pageData.studentAddress = model.StudentAddress;
                        pageData.studentAge = model.StudentAge;
                        pageData.studentName = model.StudentName;
                        pageData.hobby = model.Hobby;

                        db.Students.Add(pageData);
                        db.SaveChanges();
                        foreach (var item in model.StudentCourse)
                        {
                            StudentCourseMapping obj = new StudentCourseMapping
                            {
                                courseId = Convert.ToInt32(item),
                                studentId = db.Students.Max(e => e.studentId)
                            };
                            db.StudentCourseMappings.Add(obj);
                            db.SaveChanges();
                        }
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
        public bool EditData(StudentModel editModel)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = (from sm in db.Students
                                where sm.studentId == editModel.StudentId
                                select sm).FirstOrDefault();
                    if (data != null)
                    {
                        data.BirthDate = editModel.BirthDate;
                        data.ClassId = editModel.ClassId;
                        data.Photo = editModel.Photo;
                        data.Standard = editModel.Standard;
                        data.studentAddress = editModel.StudentAddress;
                        data.studentAge = editModel.StudentAge;
                        data.studentName = editModel.StudentName;
                        data.hobby = editModel.Hobby;
                        db.SaveChanges();
                        var removeData = db.StudentCourseMappings.Where(e => e.studentId == editModel.StudentId).ToList();
                        foreach (var item in removeData)
                        {
                            db.StudentCourseMappings.Remove(item);
                        }

                        foreach (var item in editModel.StudentCourse)
                        {
                            StudentCourseMapping obj = new StudentCourseMapping
                            {
                                courseId = Convert.ToInt32(item),
                                studentId = editModel.StudentId
                            };
                            db.StudentCourseMappings.Add(obj);
                            db.SaveChanges();
                        }
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
        public bool DeleteRecord(int id)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = db.Students.Find(id);
                    if (data != null)
                    {
                        db.Students.Remove(data);
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