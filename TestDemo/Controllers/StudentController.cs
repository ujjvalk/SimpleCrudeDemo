using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;
using TestDemo.Models.Repository;

namespace TestDemo.Controllers
{
    public class StudentController : Controller
    {
        // GET: /Student/
        public ActionResult Student(int studentId = 0)
        {
            using (var repo = new StudentRepository())
            {
                if (studentId == 0)
                {
                    var model = new StudentModel();
                    model = repo.GetList();
                    ViewBag.StudentClass = repo.ClassList(0);
                    return View(model);
                }
                ViewBag.Edit = "Edit";
                var data = repo.GetById(studentId);
                if (data != null)
                {
                    if (data.Photo != null)
                    {
                        ViewBag.ImagePath = data.Photo;
                        TempData["Photo"] = data.Photo;
                    }
                    ViewBag.StudentClass = repo.ClassList(data.ClassId ?? 0);

                    if (!string.IsNullOrEmpty(data.Hobby))
                    {
                        string[] chkname = data.Hobby.Split(',');

                        if (chkname.Any())
                        {
                            for (int i = 0; i < chkname.Count(); i++)
                            {
                                switch (chkname[i])
                                {
                                    case "Cricket":
                                        ViewBag.Cricket = true;
                                        break;
                                    case "Music":
                                        ViewBag.Music = true;
                                        break;
                                    case "Reading":
                                        ViewBag.Reading = true;
                                        break;
                                        //case "Wednesday":
                                        //    ViewBag.Wednesday = true;
                                        //    break;
                                        //case "Thursday":
                                        //    ViewBag.Thursday = true;
                                        //    break;
                                        //case "Friday":
                                        //    ViewBag.Friday = true;
                                        //    break;
                                        //case "Saturday":
                                        //    ViewBag.Saturday = true;
                                        //    break;
                                }
                            }
                        }
                    }

                }

                return PartialView("P_Form", data);
            }
        }


        [HttpPost]
        public ActionResult Student(StudentModel model, string[] hobby)
        {
            var hobbyStr = String.Join(",", hobby);
            model.Hobby = hobbyStr;
            model.Photo = TempData["Photo"].ToString();
            using (var repo = new StudentRepository())
            {
                var status = model.StudentId == 0 ? repo.AddData(model) : repo.EditData(model);
                ViewBag.SuccessMessage = status ? "Record saved successfully." : "Please try again.";
                var data = repo.GetList();
                return PartialView("P_List", data);
            }
        }

        public ActionResult Delete(int id = 0)
        {
            using (var repo = new StudentRepository())
            {
                var data = repo.DeleteRecord(id);
                if (!data)
                {
                    return HttpNotFound();
                }
                var model = repo.GetList();
                return PartialView("P_List", model);
            }
        }

        #region Upload File
        [HttpPost]
        public void UploadFile()
        {
            for (var i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                if (file != null)
                {
                    var txt = DateTime.Now.Ticks;
                    const string filePath = @"/Upload/";
                    if (!Directory.Exists(Server.MapPath(filePath)))
                    {
                        Directory.CreateDirectory(Server.MapPath(filePath));
                    }
                    var path = Server.MapPath(filePath) + txt + Path.GetExtension(file.FileName);
                    file.SaveAs(path);
                    TempData["Photo"] = filePath + txt + Path.GetExtension(file.FileName);
                }
            }
        }
        #endregion
    }
}