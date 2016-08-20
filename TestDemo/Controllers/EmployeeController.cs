using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;
using TestDemo.Models.Repository;

namespace TestDemo.Controllers
{
    public class EmployeeController : Controller
    {
        //
        // GET: /Employee/
        public ActionResult Employee()
        {
            using (var repo = new EmpRepository())
            {
                var model = repo.GetList();
                var List = repo.degList();
                ViewBag.Designation = new SelectList(List, "DesignationId", "DesName");
                model.hbList = repo.hbList();
                return View(model);
            }
        }

        [HttpPost]
        public ActionResult Employee(EmpModel model)
        {
            using (var repo = new EmpRepository())
            {
                bool flag = false;

                foreach (var item in model.hbList)
                {
                    if (item.selelcted == true)
                    {
                        if (model.EmpHobby == null)
                        {
                            model.EmpHobby = item.ID.ToString();
                        }
                        else
                        {
                            model.EmpHobby = model.EmpHobby + "," + item.ID;
                        }
                    }
                }
                model.EmpImage = TempData["EmpImage"].ToString();
                if (model.EmpId > 0)
                {
                    flag = repo.EditData(model);
                }
                else
                {
                    flag = repo.AddData(model);
                }
                ViewBag.Successmessage = flag == false ? "Please try again" : "Record saved successfully.";

                var data = repo.GetList();
                var List = repo.degList();
                ViewBag.Designation = new SelectList(List, "DesignationId", "DesName");
                return PartialView("P_List", data);
            }
        }

        public ActionResult Edit(long id = 0)
        {
            using (var repo = new EmpRepository())
            {
                var List = repo.degList();
                ViewBag.Designation = new SelectList(List, "DesignationId", "DesName");
                if (id > 0)
                {
                    var data = repo.GetById(id);
                    ViewBag.Designation = new SelectList(List, "DesignationId", "DesName", data.EmpDesignation);
                    string[] hobbyId = null;
                    if (data.EmpHobby != null)
                    {
                        hobbyId = data.EmpHobby.Split(',');
                    }
                    data.hbList = repo.hbList(hobbyId);
                    TempData["EmpImage"] = data.EmpImage;
                    return PartialView("P_Form", data);
                }
                return PartialView("P_Form");
            }
        }

        public ActionResult Delete(long id = 0)
        {
            using (var repo = new EmpRepository())
            {
                var data = repo.DeleteRecord(id);
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
                    string filePath = @"/Upload/";
                    if (!Directory.Exists(Server.MapPath(filePath)))
                    {
                        Directory.CreateDirectory(Server.MapPath(filePath));
                    }
                    var path = Server.MapPath(filePath) + txt + Path.GetExtension(file.FileName);
                    file.SaveAs(path);
                    TempData["EmpImage"] = filePath + txt + Path.GetExtension(file.FileName);
                }
            }
        }
        #endregion
    }
}